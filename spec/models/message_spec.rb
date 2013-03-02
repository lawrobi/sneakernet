require 'spec_helper'

describe Message do
  subject { FactoryGirl.build(:message) }

  describe "associated users" do
    its(:from_user) { should be_a User }
    its(:to_user) { should be_a User }
  end

end
