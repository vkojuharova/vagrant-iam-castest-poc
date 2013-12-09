class tomcat_iam::params (
    $shutdown_port  = undef,
    $ajp_port       = undef,
    $http_port      = undef,
    $ssl_port       = undef,
    $install_dir = $tomcat::install_dir
) inherits tomcat::config
{

   notice("DEBUG::tomcat_iam::params  tomcat install dir is $install_dir")

#   include tomcat

   if defined (File["${install_dir}/tomcat/conf/server.xml"]) {
        notice("DEBUG::tomcat_iam::params server.xml already defined. Will we be able to override")
   } else {
        notice("DEBUG::tomcat_iam::params server.xml is not defined. ")
   }
#   concat{ "${install_dir}/tomcat/conf/server.xml":
#           owner   => tomcat,
#           group   => tomcat,
#           mode    => 0444,
##           notify  => Class['tomcat::service'],
#          replace => true,
#       }
}