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

    it "retrieve errands picking up at a place" do
      errand
      get :index, :source_place_id => FactoryGirl.create(:place).id
      errands = JSON.parse(response.body)
      errands.count.should == 0
      get :index, :source_place_id => errand.source_place.id
      errands = JSON.parse(response.body)
      errands.first["id"].should == errand.id
    end

    it "retrieve errands dropping of at a place" do
      errand
      get :index, :arrival_place_id => FactoryGirl.create(:place).id
      errands = JSON.parse(response.body)
      errands.count.should == 0
      get :index, :arrival_place_id => errand.arrival_place.id
      errands = JSON.parse(response.body)
      errands.first["id"].should == errand.id
    end
  end

  describe "POST create" do
    let(:from) { FactoryGirl.create(:place) }
    let(:to) { FactoryGirl.create(:place) }

    it "creates a new errand and calculates errand distance" do
      sign_in FactoryGirl.create(:user)
      Geocoder.should_receive(:coordinates).twice.and_return(
                             [39.011902, -98.4842465],[35.5174913, -86.5804473])
      post :create, {:errand => {:source_place_id => from.id,
                                 :arrival_place_id => to.id }}
      e = JSON.parse(response.body)
      e["source_place_id"].should == from.id
      e["arrival_place_id"].should == to.id
      e["distance"].should == 697
      from.errands_departing.first.id.should == e["id"]
      to.errands_arriving.first.id.should == e["id"]
    end

    it "fails when no user logged in" do
      post :create, {:errand => {:source_place_id => from.id,
                                 :arrival_place_id => to.id }}
      response.status.should == 401
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

    it "fails when no user logged in" do
      put :update, :id => errand.id, :errand => {:summary => "Stewie"}
      response.status.should == 401
    end
  end

  describe "DELETE destroy" do
    it "destroys an existing errand" do
      sign_in errand.requester
      delete :destroy, :id => errand.id
      response.should be_success
      Errand.find_by_id(errand.id).should be_nil
    end

    it "fails when no user logged in" do
      delete :destroy, :id => errand.id
      response.status.should == 401
    end
  end

  describe "GET show" do
    it "fetches a single errand" do
      get :show, :id => errand.id
      JSON.parse(response.body)["id"].should == errand.id
    end
  end
end
