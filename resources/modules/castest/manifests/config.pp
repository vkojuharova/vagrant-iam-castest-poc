# class castest::config
# This is not used
class castest::config(
   $shutdown_port = '8005',
   $ajp_port = '8009',
   $http_port = '8080',
   $ssl_port = '8443',
   $install_dir = $tomcat::install_dir,
) inherits tomcat  {

concat{
    "${install_dir}/tomcat/conf/server.xml":
      owner   => tomcat,
      group   => tomcat,
      mode    => 0444,
      notify  => Class['tomcat::service'],
  }

  concat::fragment{ 'server_xml_shutdown_port':
    target  => "${install_dir}/tomcat/conf/server.xml",
    content => template('castest/server.xml.shutdown_port'),
    order   => 20,
  }

  concat::fragment{ 'server_xml_ajp_port':
    target  => "${install_dir}/tomcat/conf/server.xml",
    content => template('castest/server.xml.ajp_port'),
    order   => 40,
  }

  concat::fragment{ 'server_xml_http_port':
    target  => "${install_dir}/tomcat/conf/server.xml",
    content => template('castest/server.xml.http_port'),
    order   => 25,
  }
  concat::fragment{ 'server_xml_ssl_port':
      target  => "${install_dir}/tomcat/conf/server.xml",
      content => template('castest/server.xml.ssl_port'),
      order   => 26,
  }
}