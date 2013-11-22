# == Define: tomcat::vhost
#
# This define adds a vhost to tomcat
#
#
# === Parameters
#
# [*hostname*]
#   String.  Hostname for the vhost
#   Default: $name
#
# [*aliases*]
#   String or Array of Strings.  Aliases to associate with this vhost
#   Default: ''
#
# [*unpackWARs*]
#   Boolean.  Should wars be unpacked?
#   Default: true
#
# [*autoDeploy*]
#   Boolean.  Should new wars be auto-deployed?
#   Default: true
#
# [*contexts*]
#   Array of Hashes.  Contexts to install in this vhost.
#   Allowed keys: base, path, reloadable
#   Default ''
#
#
# === Examples
#
# * Installation:
#   tomcat::vhost { 'www':
#     aliases  => $serverAliases,
#     contexts => $contexts,
#   }
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
#
# === Copyright
#
# Copyright 2013 EvenUp.
#
define tomcat::vhost (
  $hostname = '',
  $aliases = '',
  $unpackWARs = true,
  $autoDeploy = true,
  $contexts = '',
  $contextReloadable = false,
){

  include tomcat

  $sites_mode = $::disposition ? {
    /(dev|vagrant)/ => '0777',
    default         => '0775',
  }

  $hostname_real = $hostname ? {
    ''      => $name,
    default => $hostname
  }

  $install_dir = $tomcat::install_dir

  $appBase_real = "sites/${hostname_real}"

  file { "${install_dir}/tomcat/sites/${hostname_real}":
    ensure  => directory,
    owner   => tomcat,
    group   => tomcat,
    mode    => $sites_mode,
  }

  concat::fragment{ "server_xml_${name}":
    target  => "${install_dir}/tomcat/conf/server.xml",
    content => template('tomcat/vhost.xml'),
    order   => 10,
  }
}
