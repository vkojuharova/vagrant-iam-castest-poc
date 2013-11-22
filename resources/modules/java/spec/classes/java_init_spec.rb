require 'spec_helper'
 
describe 'java', :type => :class do

  context "when called with default parameters" do

    it { should create_class('java') }
    it { should create_package('java-1.7.0-openjdk') }
    it { should create_file('/etc/profile.d/java.sh').with_mode('0555') }   

  end

end

