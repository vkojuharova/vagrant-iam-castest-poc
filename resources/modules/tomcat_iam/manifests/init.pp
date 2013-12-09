class tomcat_iam {

    notice("DEBUG::tomcat_iam::init")

    include tomcat_iam::params

    $install_dir = $tomcat::install_dir

    notice("DEBUG::tomcat_iam::init Tomcat install dir is $install_dir")


    # How can I delete a file
    if defined (File["${install_dir}/tomcat/conf/server.xml"]) {

    #    notice("DEBUG::tomcat_iam::config:: file is already defined. Stop managing it with puppet...." )

    #    file{ "${install_dir}/tomcat/conf/server.xml",
    #        replace => "no", # this is the important property
    #        ensure  => "present",
    #    }
    #    notice("DEBUG::tomcat_iam::config:: file is already defined. Should be non-managed now." )




    # Alrready defined in tomcat module. Do not redefine.
    concat{ "${install_dir}/tomcat/conf/server.xml":
        owner   => tomcat,
        group   => tomcat,
        mode    => 0444,
        notify  => Class['tomcat::service'],
        replace => true,
    }


    concat::fragment{ 'server_xml_header_iam':
    target  => "${install_dir}/tomcat/conf/server.xml",
    content => template('tomcat_iam/server.xml.header'),
    order   => 01,
    }

    concat::fragment{ 'server_xml_footer_iam':
      target  => "${install_dir}/tomcat/conf/server.xml",
      content => template('tomcat_iam/server.xml.footer'),
      order   => 99,
    }

    }








}