class mod_auth_cas {

    include mod_auth_cas::params, mod_auth_cas::install
    #mod_auth_cas::service




#    mod_auth_cas::vhost{'mod_auth_cas_vhost':
#            mod_auth_cas=>'true',
#            proxy_ajp => 'true',
#            port     => '8017' ,
#            directories =>[
#                { path=> '/', 'allow'=> 'from all', 'order'=> 'allow,deny' },
#            ] ,
#            docroot => '/var/www/castest',
#            vhost_name => 'ec2-174-129-126-123.compute-1.amazonaws.com''
#    }
}