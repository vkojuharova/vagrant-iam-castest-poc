define tomcat_iam::install(
    $shutdown_port,
    $ajp_port,
    $http_port,
    $ssl_port,
) {
    include tomcat_iam::params

   notice("DEBUG::tomcat_iam::install install_dir is $install_dir")



if defined (File["${install_dir}/tomcat/conf/server.xml"]) {
   notice("DEBUG::tomcat_iam::install server.xml already defined. Will we be able to override")
}
    concat{ "${install_dir}/tomcat/conf/server.xml":
            owner   => tomcat,
            group   => tomcat,
            mode    => 0444,
            notify  => Class['tomcat::service'],
            replace => true,
        }
}