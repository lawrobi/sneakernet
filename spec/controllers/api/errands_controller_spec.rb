require 'spec_helper'

describe Api::ErrandsController do
  let(:errand) { FactoryGirl.create(:errand) }

  describe "GET index" do
    it "retrieves all errands" do
      errand
      get :index
      errands = JSON.parse(response.body)
      errands.count.should == 1
      errands.first["id"].should == errand.id
    end
  end

  describe "POST create" do
    it "creates a new errand" do
      sign_in FactoryGirl.create(:user)
      from = FactoryGirl.create(:place)
      to = FactoryGirl.create(:place)
      post :create, {:errand => {:source_place_id => from.id,
                                 :arrival_place_id => to.id }}
      e = JSON.parse(response.body)
      e["source_place_id"].should == from.id
      e["arrival_place_id"].should == to.id
      from.errands_departing.first.id.should == e["id"]
      to.errands_arriving.first.id.should == e["id"]
    end
  end

  describe "PUT update" do
    it "updates an existing errand" do
      errand.summary.should_not == "Stewie"
      sign_in errand.requester
      put :update, :id => errand.id, :errand => {:summary => "Stewie"}
      e = JSON.parse(response.body)
      e["id"].should == errand.id
      e["summary"].should == "Stewie"
      errand.reload.summary.should == "Stewie"
    end
  end

  describe "DELETE destroy" do
    it "destroys an existing errand" do
      sign_in errand.requester
      delete :destroy, :id => errand.id
      response.should be_success
      Errand.find_by_id(errand.id).should be_nil
    end
  end

  describe "GET show" do
    it "fetches a single message" do
      get :show, :id => errand.id
      JSON.parse(response.body)["id"].should == errand.id
    end
  end
end
