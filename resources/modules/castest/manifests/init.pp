class castest {

# My tomcat module
#   tomcat::deployment { "castest":
#      path => 'puppet:///wars/castest.war',
#      shutdown_port => '8005',
#      http_port_enabled => 'true',
#      http_port => '8080',
#      ajp_port =>'8009',
#      ssl_enabled => 'true'
#      ssl_port => '8443',
#   }
# * Install a war:
#     tomcat::war{ 'jenkins':
#       app     => 'ROOT',
#       source  => 'artifactory',
#       project => 'Jenkins',
#       site    => 'www',
#       version => '1.2.3',
#     }

  include tomcat

  notice("DEBUG::castest::init:: Establishing http://$hostname/$name/")

  notice("DEBUG::castest::init.pp webapps dir is $tomcat::install_dir/tomcat/webapps")

}
