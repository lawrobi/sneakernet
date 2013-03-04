require 'spec_helper'

describe Api::ErrandOffersController do
  let(:courier) { FactoryGirl.create(:user) }
  let(:errand) { FactoryGirl.create(:errand) }
  let(:errand_offer) { FactoryGirl.create(:errand_offer) }

  describe "GET index" do
    it "retrieves all errand offers" do
      errand_offer
      get :index
      errand_offers = JSON.parse(response.body)
      errand_offers.count.should == 1
      errand_offers.first["id"].should == errand_offer.id
      errand_offers.first["errand"]["id"].should == errand_offer.errand.id
    end

    it "filters by size" do
      small_errand = FactoryGirl.create(:errand, :size => "envelope")
      small_errand_offer = FactoryGirl.create(:errand_offer, :errand => small_errand)
      get :index, :size => "envelope"
      errand_offers = JSON.parse(response.body)
      errand_offers.count.should == 1
      errand_offers.first["id"].should == small_errand_offer.id
      get :index, :size => "toaster"
      errand_offers = JSON.parse(response.body)
      errand_offers.count.should == 0
    end

    it "filters by status" do
      errand_offer.update_attributes(:status => "completed")
      get :index, :status => "pending"
      errand_offers = JSON.parse(response.body)
      errand_offers.count.should == 0
      get :index, :status => "completed"
      errand_offers = JSON.parse(response.body)
      errand_offers.count.should == 1
      errand_offers.first["id"].should == errand_offer.id
    end

    context "filtering by deliver time (in hours)" do
      let!(:fast) do
        FactoryGirl.create(:errand_offer,
                  :leaving_at => Date.today, :arriving_at => Date.today + 1.day)
      end
      let!(:medium) do
        FactoryGirl.create(:errand_offer,
                 :leaving_at => Date.today, :arriving_at => Date.today + 2.days)
      end
      let!(:slow) do
        FactoryGirl.create(:errand_offer,
                 :leaving_at => Date.today, :arriving_at => Date.today + 4.days)
      end

      it "filters by minimum delivery_time" do
        get :index, :minimum_delivery_time => 72
        errand_offers = JSON.parse(response.body)
        errand_offers.count.should == 1
        errand_offers.map { |eo| eo["id"].to_i }.should == [slow.id]
      end

      it "filters by maximum delivery time" do
        get :index, :maximum_delivery_time => 60
        errand_offers = JSON.parse(response.body)
        errand_offers.count.should == 2
        errand_offers.map { |eo| eo["id"].to_i }.should =~ [fast.id, medium.id]
      end

      it "filters by range of delivery time" do
        get :index, :minimum_delivery_time => 36, :maximum_delivery_time => 144
        errand_offers = JSON.parse(response.body)
        errand_offers.count.should == 2
        errand_offers.map { |eo| eo["id"].to_i }.should =~ [medium.id, slow.id]
      end
   end

    context "filtering by distance" do
      let!(:short) do
        FactoryGirl.create(:errand_offer, :errand =>
                           FactoryGirl.create(:errand, :distance => 10))
      end
      let!(:medium) do
        FactoryGirl.create(:errand_offer, :errand =>
                           FactoryGirl.create(:errand, :distance => 100))
      end
      let!(:long) do
        FactoryGirl.create(:errand_offer, :errand =>
                           FactoryGirl.create(:errand, :distance => 1000))
      end

      it "filters by minimum distance" do
        get :index, :minimum_distance => 11
        errand_offers = JSON.parse(response.body)
        errand_offers.count.should == 2
        errand_offers.map { |eo| eo["id"].to_i }.should =~ [medium.id, long.id]
      end

      it "filters by maximum distance" do
        get :index, :maximum_distance => 500
        errand_offers = JSON.parse(response.body)
        errand_offers.count.should == 2
        errand_offers.map { |eo| eo["id"].to_i }.should =~ [short.id, medium.id]
      end

      it "filters by range of distance" do
        get :index, :minimum_distance => 36, :maximum_distance => 745
        errand_offers = JSON.parse(response.body)
        errand_offers.count.should == 1
        errand_offers.map { |eo| eo["id"].to_i }.should == [medium.id]
      end
    end
  end

  describe "POST create" do
    it "creates a new errand offer" do
      sign_in courier
      post :create, {:errand_offer => {:errand_id => errand.id, :bid => 100 }}
      eo = JSON.parse(response.body)
      eo["bid"].should == 100
      eo["errand_id"].should == errand.id
      eo["courier_id"].should == courier.id
    end

    it "fails when no user logged in" do
      post :create, {:errand_offer => {:errand_id => errand.id, :bid => 100 }}
      response.status.should == 401
    end
  end

  describe "PUT update" do
    it "updates an existing errand offer" do
      errand_offer.message.should_not == "Stewie"
      sign_in errand_offer.courier
      put :update, :id => errand_offer.id,
                   :errand_offer => {:message => "Stewie"}
      eo = JSON.parse(response.body)
      eo["id"].should == errand_offer.id
      eo["message"].should == "Stewie"
      errand_offer.reload.message.should == "Stewie"
    end

    it "fails when no user logged in" do
      put :update, :id => errand_offer.id,
                   :errand_offer => {:message => "Stewie"}
      response.status.should == 401
    end
  end

  describe "DELETE destroy" do
    it "destroys an existing errand" do
      sign_in errand_offer.courier
      delete :destroy, :id => errand_offer.id
      response.should be_success
      ErrandOffer.find_by_id(errand_offer.id).should be_nil
    end

    it "fails when no user logged in" do
      delete :destroy, :id => errand_offer.id
      response.status.should == 401
    end
  end

  describe "GET show" do
    it "fetches a single errand offer" do
      get :show, :id => errand_offer.id
      JSON.parse(response.body)["id"].should == errand_offer.id
    end
  end
end
