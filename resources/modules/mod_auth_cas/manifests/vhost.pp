define mod_auth_cas::vhost (
      $mod_auth_cas                = true,
      $proxy_ajp                   = true,
      $port                        = '443',
      $directories                  = undef,
      $docroot                      = undef,
) {

include  mod_auth_cas::params
#inherits apache::vhost{

#      if $mod_auth_cas {
#           include mod_auth_cas::mod::auth_cas
#      }

 #Load mod_ajp if needed and not loaded
  if $proxy_ajp {
      if ! defined(Class['mod_auth_cas::mod::proxy_ajp']) {
        include apache::mod::proxy
        include mod_auth_cas::mod::proxy_ajp
      }
    }

    notice ("DEBUG::mod_auth_cas::vhost confd folder is $mod_auth_cas::params::confd_dir")
     apache::vhost{$::fqdn:
#         vhost_name => 'localhost',
         port    => $port,
         serveradmin     => 'vanja_kojuharova@harvard.edu',
         access_log_file => "castest_access_log.log",
         priority        => '1',
         docroot        => $docroot,
         ssl            => true,
         custom_fragment =>  "Include $mod_auth_cas::params::confd_dir/auth_cas.conf"  ,
         sslproxyengine => true ,
         directories    => [ { path=> "$docroot", 'allow'=> 'from all', options=>['Indexes',  'FollowSymLinks'], order => ['Allow','Deny'] },
                             { path=> "/castest", 'allow'=> 'from all', options=>['Indexes',  'FollowSymLinks'], order => ['Allow','Deny'] }   ],

         #directories    => [ { path => '/path/to/directory', order => 'Allow, Deny' } ],
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