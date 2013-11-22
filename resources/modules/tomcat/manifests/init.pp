# == Class: tomcat
#
# This class installs and configures tomcat from source
#
#
# === Parameters
#
# [*install_dir*]
#   String.  Where should tomcat be unpacked (/tomcat is appended)
#   Default: /usr/share
#
# [*log_dir*]
#   String.  Location logs should be written
#   Default: /var/log/tomcat
#
# [*sites_sub_dir*]
#   String.  Where should sites be installed
#   Default: sites
#
# [*version*]
#   String.  Version of tomcat to be installed
#   Default: 7.0.40
#
# [*auto_upgrade*]
#   Boolean.  Whether puppet will update the symlink for newer versions of tomcat
#   Default: false
#
# [*static_url*]
#   String.  URL to download tomcat from
#   Default: '' (apache mirror)
#
# [*admin_pass*]
#   String.  Password to set for the admin user
#   Default: changeme
#
# [*java_opts*]
#   String.  Java options to pass to tomcat
#   Default: -XX:+DoEscapeAnalysis -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -XX:+UseConcMarkSweepGC -XX:+CMSIncrementalMode -XX:PermSize=128m -XX:MaxPermSize=128m -Xms512m -Xmx512m
#
# [*mange_service*]
#   Boolean.  Whether puppet should manage the service
#   Default: true
#
# [*monitoring*]
#   String.  Which monitoring system checks to install
#   Default: ''
#   Valid options: sensu
#
#
# === Examples
#
# * Installation:
#     class { 'tomcat': }
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
class tomcat(
  $install_dir    = '/usr/share',
  $log_dir        = '/var/log/tomcat',
  $sites_sub_dir  = 'sites',
  $version        = '7.0.40',
  $auto_upgrade   = false,
  $static_url     = '',
  $admin_pass     = 'changeme',
  $java_opts      = '-XX:+DoEscapeAnalysis -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -XX:+UseConcMarkSweepGC -XX:+CMSIncrementalMode -XX:PermSize=128m -XX:MaxPermSize=128m -Xms512m -Xmx512m',
  $manage_service = true,
  $monitoring     = '',
) {

  $sites_dir = "${install_dir}/tomcat/${sites_sub_dir}"
  $real_url = $static_url ? {
    ''      => "http://download.nextag.com/apache/tomcat/tomcat-7/v${version}/bin",
    default => $static_url
  }
  require java

  class { 'tomcat::install':
    install_dir   => $install_dir,
    log_dir       => $log_dir,
    sites_dir     => $sites_dir,
    version       => $version,
    auto_upgrade  => $auto_upgrade,
    real_url      => $real_url,
  }

  class { 'tomcat::config':
    install_dir => $install_dir,
    admin_pass  => $admin_pass,
    java_opts   => $java_opts,
  }

  class { 'tomcat::service':
    manage      => $manage_service,
    monitoring  => $monitoring,
  }

  # Containment
  anchor { 'tomcat::begin': }
  anchor { 'tomcat::end': }

  Anchor['tomcat::begin'] ->
  Class['tomcat::install'] ->
  Class['tomcat::config'] ->
  Class['tomcat::service'] ->
  Anchor['tomcat::end']

}
