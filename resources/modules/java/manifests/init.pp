# == Class: java
#
# This class installs the java package
#
# === Parameters
#
# [*ensure*]
#   String.  Controls whether java should be installed or absent.
#   Valid options are: present, absent, latest, installed, or a specific version
#
#
# === Examples
#
# * Installation:
#     class { 'java': }
#
# * Removal/decommissioning:
#     class { 'java':
#       ensure => 'absent',
#     }
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
# === Copyright
#
# Copyright 2013 EvenUp.
#
class java (
  $ensure = 'latest'
){

  package { 'java-1.7.0-openjdk':
    ensure  => $ensure
  }

  file {
    '/etc/profile.d/java.sh':
      ensure  => file,
      mode    => '0555',
      owner   => root,
      group   => root,
      source  => 'puppet:///modules/java/java.profile'
  }
}
