# Definition: apache::vhost
#
# This class installs Apache Virtual Hosts
#
# Parameters:
# - The $mod_auth_cas - use mod_auth_cas module; defaults to true
# - The $proxy_ajp use proxy; defaults to true
# - The $port to configure the host on
# - The $directories to configure the Directories directive for the Virtual Host
# - The $docroot to configure the Document Root
# - The $servername to configure the servername for the Virtual Host.
# - The $ip to configure the servername for the Virtual Host
# Actions:
# - Install Apache mod_auth_cas module Virtual Host
#
# Requires:
# - The apache class
#
# Sample Usage:
#
#  # Simple vhost definition:
#  mod_auth_cas::vhost{'mod_auth_cas_vhost':
#          mod_auth_cas  => true,
#          proxy_ajp     => true,
#          port          => $castest_ssl_port,
#          directories   => [
#                { path  => '/',
#                'allow' => 'from all',
#                'order' => 'allow,deny' },
#                ] ,
#          docroot       => '/var/www/castest',
#  }
#
define mod_auth_cas::vhost (
      $mod_auth_cas                = true,
      $proxy_ajp                   = true,
      $port                        = '443',
      $servername                  = $name,
      $directories                 = undef,
      $docroot                     = undef,
      $ip                          = undef,
) {

include  mod_auth_cas::params

#inherits apache::vhost{

#      if $mod_auth_cas {
#           include mod_auth_cas::mod::auth_cas
#      }

# Load mod_ajp if needed and not loaded
  if $proxy_ajp {
      if ! defined(Class['mod_auth_cas::mod::proxy_ajp']) {
        include apache::mod::proxy
        include mod_auth_cas::mod::proxy_ajp
      }
  }

  notice ('DEBUG::mod_auth_cas::vhost confd folder is ')
  notice ($mod_auth_cas::params::confd_dir)

  apache::vhost{$::fqdn:
#    vhost_name     => 'localhost',
    port            => $port,
    serveradmin     => 'vanja_kojuharova@harvard.edu',
    access_log_file => 'castest_access_log.log',
    priority        => '1',
    docroot         => $docroot,
    ssl             => true,
    custom_fragment =>
        "Include ${mod_auth_cas::params::confd_dir}/auth_cas.conf",
    sslproxyengine  => true ,
    directories     => [
        { path      => $docroot,
        'allow'     => 'from all',
        options     =>['Indexes',  'FollowSymLinks'],
        order       => ['allow','deny']
        } ],
    servername      => $servername,
    ip              => $ip,
  }

# We don't care where the file is located, just what to put in it.
# concat::fragment {'apache-vhost-myvhost-main':
#  target  => 'apache-vhost-myvhost',
#  content => '<virtualhost *:80>',
#  order   => 01,
# }

# concat::fragment {'apache-vhost-myvhost-close':
#  target  => 'apache-vhost-myvhost',
#  content => 'Include </virtualhost>',
#  order   => 99,
# }

#    define mod_auth_cas::vhost {
#          $addr_port = $name
#      include mod_auth_cas::params
#
#      # Template uses: $addr_port
#      concat::fragment { "NameVirtualHost ${addr_port}":
#        target  => $apache::params::ports_file,
#        content => template('apache/namevirtualhost.erb'),
#      }
#    }




}