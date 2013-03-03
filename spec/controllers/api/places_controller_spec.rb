require 'spec_helper'

describe Api::PlacesController do
  let(:place) { FactoryGirl.create(:place) }

  describe "GET show" do
    it "fetches a single place" do
      get :show, :id => place.id
      JSON.parse(response.body)["id"].should == place.id
    end
  end
end
