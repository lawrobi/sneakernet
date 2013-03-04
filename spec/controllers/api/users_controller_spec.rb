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
      u["requests_completed"].map {|e| e["id"]}.should == [completed_request.id]
      u["requests_pending"].map {|e| e["id"]}.should == [pending_request.id]
      u["errand_offers_completed"].map {|eo| eo["id"]}
        .should == [completed_errand.id]
      u["errand_offers_pending"].map {|eo| eo["id"]}
        .should == [pending_errand.id]
    end
  end
end
