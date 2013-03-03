require 'spec_helper'

describe Errand do
  subject { FactoryGirl.build(:errand)}

  describe "associated places" do
    its(:source_place) { should be_a Place }
    its(:arrival_place) { should be_a Place }
  end

  its(:requester) { should be_a User }

  context "it has an accepted offer associated with it" do
    let(:errand_offer) { FactoryGirl.create(:errand_offer, :errand => subject)}

    before { subject.save }

    its(:errand_offers) { should include(errand_offer) }
  end
end
