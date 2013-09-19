node default {
  stage { 'pre': before => Stage['main'] }
  #class { 'epel': stage => 'pre' }
  class { 'common': }

  class { 'openstack::repo': } ->
  class { 'openstack::all':
    public_address       => $::ipaddress,
    public_interface     => 'eth0',
    private_interface    => 'eth1',
    admin_email          => 'some_admin@some_company',
    admin_password       => 'admin_password',
    keystone_admin_token => 'keystone_admin_token',
    keystone_db_password => 'keystone_db_password',
    cinder_db_password   => 'cinder_db_password',
    cinder_user_password => 'cinder_user_password',
    mysql_root_password  => 'mysql_root_password',
    nova_user_password   => 'nova_user_password',
    nova_db_password     => 'nova_db_password',
    glance_user_password => 'glance_user_password',
    glance_db_password   => 'glance_db_password',
    rabbit_password      => 'rabbit_password',
    rabbit_user          => 'rabbit_user',
    libvirt_type         => 'kvm',
    fixed_range          => '10.0.0.0/24',
    secret_key           => '12345',
    neutron               => false,
  }
  #class { 'openstack::auth_file':
  #  admin_password       => 'admin_password',
  #  controller_node      => $::ipaddress_lo,
  #  keystone_admin_token => 'keystone_admin_token',
  #}
}
