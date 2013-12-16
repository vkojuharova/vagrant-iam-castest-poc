class tomcat_iam::config (
    $shutdown_port  = undef,
    $ajp_port       = undef,
    $http_port      = undef,
    $ssl_port       = undef,
    $install_dir = $tomcat::install_dir
) #inherits tomcat::config
{

#    require tomcat
    include tomcat::config

    notice("DEBUG::tomcat_iam::config tomcat install dir is $install_dir")

    notice("DEBUG::tomcat_iam::config:: File title == 1")
     File<| title =="${install_dir}/tomcat/conf/server.xml" |> {
#     File["${install_dir}/tomcat/conf/server.xml"]{
        content=> undef,
#        ensure=> absent,
     }

    notice("DEBUG::tomcat_iam::config:: Concat title == 1")
     Concat<| title =="${install_dir}/tomcat/conf/server.xml" |> {
           #     File["${install_dir}/tomcat/conf/server.xml"]{
                   path=> undef,
#                   ensure => absent,
     }
     notice("DEBUG::tomcat_iam::config:: File title == 2")
      File<| title =="${install_dir}/tomcat/conf/server.xml" |> {
 #     File["${install_dir}/tomcat/conf/server.xml"]{
         content=> template("tomcat_iam/server.xml.erb"),
 #        ensure=> absent,
      }
    notice("DEBUG::tomcat_iam::config:: File title == 2")
    if defined (File["${install_dir}/tomcat/conf/server.xml"]) {
         notice("DEBUG::tomcat_iam::config server.xml is still managed....")
    } else {
        notice("DEBUG::tomcat_iam::config server.xml is not managed...")
    }

    File<| title == "server_xml_header" |> {
        content => undef,
        ensure => absent,
    }
    File<| title == "server_xml_footer" |> {
        content => undef,
        ensure => absent,
    }
    if defined (File['server_xml_header']) {
       notice("DEBUG::tomcat_iam::config fragment header is still managed....")
    }  else {
       notice("DEBUG::tomcat_iam::config fragment header is not managed....")
    }
    if defined (File['server_xml_footer']) {
           notice("DEBUG::tomcat_iam::config fragment header is still managed....")
    }  else {
       notice("DEBUG::tomcat_iam::config fragment header is not managed....")
    }

#    concat::fragment['server_xml_header']{
#      content => template('tomcat_iam/server.xml.header'),
#      content => undef,
#      ensure => absent,
#    }

#    concat::fragment['server_xml_footer']{
#       content => template('tomcat_iam/server.xml.footer'),
#       content => undef,
#       ensure => absent,
#    }

#concat{ 'server_xml_iam':
#          path    => "${install_dir}/tomcat/conf/server.xml",
#          owner   => tomcat,
#          group   => tomcat,
#          mode    => 0444,
#          notify  => Class['tomcat::service'],
#      }


#concat::fragment{ 'server_xml_header_iam':
#    target  => "${install_dir}/tomcat/conf/server.xml",
#    content => template('tomcat_iam/server.xml.header'),
#    order   => 01,
#  }

#concat::fragment{ 'server_xml_footer_iam':
#    target  => "${install_dir}/tomcat/conf/server.xml",
#   content => template('tomcat_iam/server.xml.footer'),
#    order   => 99,
#  }


#    concat{
#        "${install_dir}/tomcat/conf/server.xml":
#          owner   => tomcat,
#          group   => tomcat,
#          mode    => 0444,
#          notify  => Class['tomcat::service'],
#      }

#   concat::fragment{ 'server_xml_footer':
#    target  => "${install_dir}/tomcat/conf/server.xml",
#    content => template('tomcat/server.xml.footer'),
#    order   => 99,
#  }

}