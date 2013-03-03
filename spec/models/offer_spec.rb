require 'spec_helper'

describe Offer do
  subject { FactoryGirl.build(:offer)}

  describe "associated places" do
    its(:source_place) { should be_a Place }
    its(:arrival_place) { should be_a Place }
  end

  its(:courier) { should be_a User }
end
