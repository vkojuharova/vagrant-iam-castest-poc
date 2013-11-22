require 'spec_helper'

describe 'tomcat::app_config', :type => :define do
  let(:title) { 'tomcat_config' }
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat' } }

  context 'no reload' do
    let(:params) { {
      :site     => 'mysite',
      :app      => 'myapp',
      :file     => 'config.properties',
      :content  => 'disabled=true',
    } }

    it { should contain_file('/usr/share/tomcat/sites/mysite/myapp/config.properties').with_notify('') }
  end

  context 'reload' do
    let(:params) { {
      :site           => 'mysite',
      :app            => 'myapp',
      :file           => 'config.properties',
      :content        => 'disabled: true',
      :reload_tomcat  => true,
    } }

    it { should contain_file('/usr/share/tomcat/sites/mysite/myapp/config.properties').with_notify('Class[Tomcat::Service]')}
  end

end
