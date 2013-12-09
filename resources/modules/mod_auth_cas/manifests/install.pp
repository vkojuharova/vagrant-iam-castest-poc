class mod_auth_cas::install(
 $servername    = $mod_auth_cas::params::servername,
 $confd_dir     = $mod_auth_cas::params::confd_dir,
){

      notice("DEBUG::mod_auth_cas::install servername is $servername")

#Mod Auth CAS cache folder
    file { '/mod_auth_cas':
        ensure  => directory,
        owner   => 'root',
        group   => 'root',
        mode    => '0777',
        notify  => Class['Apache::Service'],
        require => Package['httpd'],
    }

    file {'/var/www/castest':
        ensure => directory,
        owner  => 'root',
        group => 'root',
        mode    => '0777',
        notify  => Class['Apache::Service'],
        require => Package['httpd'],
    }
    notice("DEBUG: Install.pp: Apache confd_dir ${confd_dir}")

    file {  'auth_cas':
        ensure    => file,
        path      => "${confd_dir}/auth_cas.conf",
        content   => template ('mod_auth_cas/mod/auth_cas.conf.erb'),
        require   => Exec["mkdir ${apache::mod_dir}"],
        before    => File [$apache::mod_dir],
        notify  => Class['Apache::Service'],
    }

    file {'mod_auth_cas.so':
        ensure  => file,
        path => "/usr/lib64/httpd/modules/mod_auth_cas.so",
#        path => "${confd_dir}/mod_auth_cas.so",
#        path    => "/etc/httpd/modules/mod_auth_cas.so",
        source  => 'puppet:///modules/mod_auth_cas/mod_auth_cas.so',
        group   => 'root',
        owner   => 'root',
        mode    => '0755',
        notify  => Class['Apache::Service'],
        require => Package['httpd'],
    }
    notice("DEBUG::mod_auth_cas::install: Servername is ${servername}")
    notice("DEBUG::mod_auth_cas::install: Name is ${name}")
    notice("DEBUG::mod_auth_cas::install: Host is ${hostname}")
    notice("DEBUG::mod_auth_cas::install: FQDN is ${fqdn}")
    notice("DEBUG::mod_auth_cas::install: nvh_addr_port is  ${nvh_addr_port}")
    notice("DEBUG::mod_auth_cas::install: vhost_name is  ${vhost_name}")

}