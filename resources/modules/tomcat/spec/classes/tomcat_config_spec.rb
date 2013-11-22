require 'spec_helper'

describe 'tomcat::config', :type => :class do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat' } }
  let(:params) { { :install_dir => '/usr/share', :admin_pass => 'mysecret', :java_opts => '' } }

  it { should create_class('tomcat::config') }
  it { should contain_file('/usr/share/tomcat/conf/catalina.policy') }
  it { should contain_file('/usr/share/tomcat/conf/context.xml') }
  it { should contain_file('/usr/share/tomcat/conf/logging.properties') }
  it { should contain_file('/usr/share/tomcat/conf/Catalina').with_ensure('directory') }
  it { should contain_file('/usr/share/tomcat/conf/Catalina/localhost').with_ensure('directory') }
  it { should contain_file('/usr/share/tomcat/conf/tomcat-users.xml').with(
    'mode'  => '0440',
    'owner' => 'tomcat',
    'group' => 'tomcat'
  ) }
  it { should contain_file('/usr/share/tomcat/bin/setenv.sh') }
  it { should contain_file('/usr/share/tomcat/bin/web.xml') }
  it { should contain_concat('/usr/share/tomcat/conf/server.xml') }
  it { should contain_concat__fragment('server_xml_header') }
  it { should contain_concat__fragment('server_xml_footer') }
  it { should contain_logrotate__file('tomcat') }

end
