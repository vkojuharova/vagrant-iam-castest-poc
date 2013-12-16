define tomcat_iam::install(
    $shutdown_port,
    $ajp_port,
    $http_port,
    $ssl_port,
) {

   require tomcat, tomcat::config

#   include tomcat_iam::params

include tomcat_iam::config
#   class {'tomcat_iam::config':
#          shutdown_port=> $shutdown_port,
#          ajp_port => $ajp_port,
#          http_port => $http_port,
#          ssl_port => $ssl_port,
#          }

   notice("DEBUG::tomcat_iam::install FINITTOoo...")
}