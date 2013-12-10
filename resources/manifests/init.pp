node default {
  stage { 'pre': before => Stage['main'] }
  class { 'epel': stage => 'pre' }
  class { 'common': }

  # Install and configure Apache
  class { 'apache': }

  #Install and configure mod_auth_cas Apache module
  class { 'mod_auth_cas': }

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
#        ajp_port       => '8003',
#        http_port      => '8021',
#        ssl_port       => '8022',
#  }

}
