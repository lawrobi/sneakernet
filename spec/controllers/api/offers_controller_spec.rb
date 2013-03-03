require 'spec_helper'

describe Api::OffersController do
  let(:offer) { FactoryGirl.create(:offer) }

  describe "GET index" do
    it "retrieves all offers" do
      offer
      get :index
      offers = JSON.parse(response.body)
      offers.count.should == 1
      offers.first["id"].should == offer.id
    end
  end

  describe "POST create" do
    it "creates a new offer" do
      sign_in FactoryGirl.create(:user)
      from = FactoryGirl.create(:place)
      to = FactoryGirl.create(:place)
      post :create, {:offer => {:source_place_id => from.id,
                                 :arrival_place_id => to.id }}
      e = JSON.parse(response.body)
      e["source_place_id"].should == from.id
      e["arrival_place_id"].should == to.id
      from.offers_departing.first.id.should == e["id"]
      to.offers_arriving.first.id.should == e["id"]
    end
  end

  describe "PUT update" do
    it "updates an existing offer" do
      offer.summary.should_not == "Stewie"
      sign_in offer.courier
      put :update, :id => offer.id, :offer => {:summary => "Stewie"}
      e = JSON.parse(response.body)
      e["id"].should == offer.id
      e["summary"].should == "Stewie"
      offer.reload.summary.should == "Stewie"
    end
  end

  describe "DELETE destroy" do
    it "destroys an existing offer" do
      sign_in offer.courier
      delete :destroy, :id => offer.id
      response.should be_success
      Errand.find_by_id(offer.id).should be_nil
    end
  end

  describe "GET show" do
    it "fetches a single offer" do
      get :show, :id => offer.id
      JSON.parse(response.body)["id"].should == offer.id
    end
  end
end
