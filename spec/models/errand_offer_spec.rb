require 'spec_helper'

describe ErrandOffer do
  subject { FactoryGirl.build(:errand_offer) }

  its(:errand) { should be_a Errand }
  its(:courier) { should be_a User }
end
