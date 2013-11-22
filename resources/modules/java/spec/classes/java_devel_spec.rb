require 'spec_helper'
 
describe 'java::devel', :type => :class do

  context "when called with default parameters" do

    it { should create_class('java::devel') }
    it { should create_package('java-1.7.0-openjdk-devel.x86_64') }

  end

end

