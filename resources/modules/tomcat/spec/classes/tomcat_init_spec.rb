require 'spec_helper'
 
describe 'tomcat', :type => :class do
  let(:facts) { { :disposition => 'prod', :concat_basedir => '/var/lib/puppet/concat' } }

  it { should create_class('tomcat') }

end
