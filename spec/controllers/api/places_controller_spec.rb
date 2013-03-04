require 'spec_helper'

describe Api::PlacesController do
  let(:place) { FactoryGirl.create(:place) }

  describe "GET show" do
    it "fetches a single place" do
      get :show, :id => place.id
      JSON.parse(response.body)["id"].should == place.id
    end
  end

  describe "GET index" do
    it "can filter places by prefix search on display name, sorted by population" do
      FactoryGirl.create(:place, :display_name => "Petaluma, CA",
                         :country => "United States", :population => 100)
      FactoryGirl.create(:place, :display_name => "Pitsfield, MA",
                         :country => "United States", :population => 1000)
      FactoryGirl.create(:place, :display_name => "Pittsburgh, PA",
                         :country => "United States", :population => 10)
      get :index, :q => "P"
      places = JSON.parse(response.body)
      places[0]["display_name"].should == "Pitsfield, MA"
      places[1]["display_name"].should == "Petaluma, CA"
      places[2]["display_name"].should == "Pittsburgh, PA"
      get :index, :q => "Pi"
      places = JSON.parse(response.body)
      places[0]["display_name"].should == "Pitsfield, MA"
      places[1]["display_name"].should == "Pittsburgh, PA"
      get :index, :q => "Pittsburgh, P"
      places = JSON.parse(response.body)
      places[0]["display_name"].should == "Pittsburgh, PA"
    end

    it "orders US cities before world cities" do
      FactoryGirl.create(:place, :display_name => "Rome, NY",
                         :country => "United States", :population => 100)
      FactoryGirl.create(:place, :display_name => "Rome, Italy",
                         :country => "Italy", :population => 1000)
      get :index, :q => "Rome"
      places = JSON.parse(response.body)
      places[0]["display_name"].should == "Rome, NY"
      places[1]["display_name"].should == "Rome, Italy"
    end
  end
end
