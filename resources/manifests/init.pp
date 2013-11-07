node default {
  stage { 'pre': before => Stage['main'] }
  class { 'epel': stage => 'pre' }
  class { 'common': }

  # Install and configure Apache
  class { 'apache': }

  # Install and configure Tomcat
  class { 'tomcat':
    version => '7.0.47',
  }
}
