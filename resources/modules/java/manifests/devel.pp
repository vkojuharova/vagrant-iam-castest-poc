# == Class: java::devel
#
# This class installs the java development package
#
# === Parameters
#
# [*ensure*]
#   String.  Controls whether java-devel should be installed or absent.
#   Valid options are: present, absent, latest, installed, or a specific version
#
#
# === Examples
#
# * Installation:
#     class { 'java::devel': }
#
# * Removal/decommissioning:
#     class { 'java::devel':
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
class java::devel (
  $ensure = 'latest'
){

  package {
    'java-1.7.0-openjdk-devel.x86_64':
      ensure  => $ensure,
  }
}
