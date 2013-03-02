require 'spec_helper'

describe Place do
  subject { FactoryGirl.build(:place) }
  let(:user) { FactoryGirl.build(:user) }
  let(:errand) { FactoryGirl.build(:errand) }

  it "has associated users from this place" do
    user.home_place = subject
    user.save
    subject.users.should == [user]
    subject.should == user.home_place
  end

  it "has associated errands departing" do
    errand.source_place = subject
    errand.save
    subject.errands_departing.should == [errand]
    subject.should == errand.source_place
  end

  it "has associated errands arriving" do
    errand.arrival_place = subject
    errand.save
    subject.errands_arriving.should == [errand]
    subject.should == errand.arrival_place
  end
end
