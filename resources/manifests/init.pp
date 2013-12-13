node default {
  stage { 'pre': before => Stage['main'] }
  class { 'epel': stage => 'pre' }
  class { 'common': }

  # Install and configure Apache
  class { 'apache': }

  #Install and configure mod_auth_cas Apache module
  class { 'mod_auth_cas': }

  $castest_ssl_port     = '8017'
  $default_http_port    = '80'
  $default_ssl_port     = '443'

# Firewall updates. Those will need to be restricted more.
  resources { "firewall":
    purge => true
  }
  Firewall {
    before  => Class['iam_firewall::post'],
    require => Class['iam_firewall::pre'],
  }
  class { ['iam_firewall::pre', 'iam_firewall::post']: }

# Firewall rules for current project
  firewall { '011 allow http and https access':
      ensure => 'present' ,
      action => 'accept',
      proto  => 'tcp',
      dport   => [$default_ssl_port,$default_http_port, $castest_ssl_port],
  }
  mod_auth_cas::vhost{'mod_auth_cas_vhost':
          mod_auth_cas=>'true',
          proxy_ajp => 'true',
          port     => '8017' ,
          directories =>[
              { path=> '/', 'allow'=> 'from all', 'order'=> 'allow,deny' },
          ] ,
          docroot => '/var/www/castest',
#          servername => 'ec2-174-129-126-123.compute-1.amazonaws.com',
  }

  # Install and configure Tomcat
  class { 'tomcat':
    version => '7.0.47',
  }

  #Deploy castest application
  class{'castest':}

  castest::deploy{"castest":
    deploy_dir =>   "$tomcat::install_dir/tomcat/webapps",
      #    path  =>  " /vagrant/resources/modules/castest/files/castest.war",
    path  =>  "puppet:///modules/castest/castest.war",
  }

  #Tomcat changes
#  class{'tomcat_iam':}

#  tomcat_iam::install{'tomcat_iam_config':
#        shutdown_port  => '8020',
#        ajp_port       => '8009',
#        http_port      => '8021',
#        ssl_port       => '8022',
#  }

}
