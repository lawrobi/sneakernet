require 'spec_helper'

describe User do
  subject { FactoryGirl.create(:user) }

  it "can have associated requested errands" do
    errand = FactoryGirl.create(:errand, :requester => subject)
    subject.requested_errands.should include(errand)
  end

  it "can have associated offered errands" do
    offer = FactoryGirl.create(:offer, :courier => subject)
    subject.offers.should include(offer)
  end
end
