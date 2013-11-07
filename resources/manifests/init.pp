node default {
  stage { 'pre': before => Stage['main'] }
  class { 'epel': stage => 'pre' }
  class { 'common': }

  # Install and configure Apache
  class { 'apache':
    default_mods  => true,
    default_vhost => true,
  }

  class { 'apache::mod::proxy_http': }

  # Install and configure Tomcat
  class { 'tomcat': }
}
