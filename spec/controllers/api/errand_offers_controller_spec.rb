require 'spec_helper'

describe Api::ErrandOffersController do
  let(:courier) { FactoryGirl.create(:user) }
  let(:errand) { FactoryGirl.create(:errand) }

  describe "POST create" do
    it "creates a new errand offer" do
      sign_in courier
      post :create, {:errand_offer => {:errand_id => errand.id, :bid => 100 }}
      eo = JSON.parse(response.body)
      eo["bid"].should == 100
      eo["errand_id"].should == errand.id
      eo["courier_id"].should == courier.id
    end
  end
end
