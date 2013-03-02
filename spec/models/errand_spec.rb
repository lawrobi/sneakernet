require 'spec_helper'

describe Errand do
  subject { FactoryGirl.build(:errand)}

  describe "associated places" do
    its(:source_place) { should be_present }
    its(:arrival_place) { should be_present }
  end

  describe "associated users" do
    its(:requester) { should be_present }
    its(:assignee) { should be_present }
  end
end
