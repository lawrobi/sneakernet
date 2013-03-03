require 'spec_helper'

describe Errand do
  subject { FactoryGirl.build(:errand)}

  describe "associated places" do
    its(:source_place) { should be_a Place }
    its(:arrival_place) { should be_a Place }
  end

  its(:requester) { should be_a User }
end
