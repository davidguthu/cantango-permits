require 'spec_helper'

shared_examples_for CanTango::Configuration::PermitRegistry do
  it "should respond to permit type methods" do
    [:user_type, :account_type, :role, :role_group].each do |permit_type|
      subject.get(permit_type).should_not be_nil 
    end
  end
end