require 'spec_helper'

describe Api::UsersController do
  let(:user) { FactoryGirl.create(:user) }

  describe "GET show" do
    it "fetches a single user" do
      get :show, :id => user.id
      JSON.parse(response.body)["id"].should == user.id
    end

    it "sideloads the users requested errands and errand offers assigned" do
      completed_request = FactoryGirl.create(:errand, :requester => user)
      FactoryGirl.create(:errand_offer, :status => "completed", :errand => completed_request)
      pending_request = FactoryGirl.create(:errand, :requester => user)
      completed_errand = FactoryGirl.create(:errand_offer, :courier => user,
                                            :status => "completed")
      pending_errand = FactoryGirl.create(:errand_offer, :courier => user,
                                          :status => "pending")
      get :show, :id => user.id
      u = JSON.parse(response.body)
      u["id"].should == user.id
      u["requested_errands_completed"].map {|e| e["id"]}.should == [completed_request.id]
      u["requested_errands_pending"].map {|e| e["id"]}.should == [pending_request.id]
      u["errand_offers_completed"].map {|eo| eo["id"]}
        .should == [completed_errand.id]
      u["errand_offers_pending"].map {|eo| eo["id"]}
        .should == [pending_errand.id]
    end
  end

  describe "GET requested_errands" do
    it "gets the users requested errands" do
      completed_request = FactoryGirl.create(:errand, :requester => user)
      FactoryGirl.create(:errand_offer, :status => "completed", :errand => completed_request)
      pending_request = FactoryGirl.create(:errand, :requester => user)
      get :requested_errands, :id => user.id
      errands = JSON.parse(response.body)
      errands.map {|e| e["id"] }.should ==
        [completed_request.id, pending_request.id]
      binding.pry
    end
  end

  describe "GET accepted_errands" do
    it "gets the users accepted errand offers as courier" do
      completed_errand = FactoryGirl.create(:errand_offer, :courier => user,
                                            :status => "completed")
      pending_errand = FactoryGirl.create(:errand_offer, :courier => user,
                                          :status => "pending")
      get :accepted_errands, :id => user.id
      errands = JSON.parse(response.body)
      errands.map {|e| e["id"] }.should =~
        [completed_errand.id, pending_errand.id]
      binding.pry
    end
  end
end
