class mod_auth_cas {

    include mod_auth_cas::params, mod_auth_cas::install
    #mod_auth_cas::service




    mod_auth_cas::vhost{'mod_auth_cas_vhost':
            mod_auth_cas=>'true',
            proxy_ajp => 'true',
            port     => '8017' ,
    }

}