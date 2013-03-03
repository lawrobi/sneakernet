require 'spec_helper'

describe Api::UsersController do
  let(:user) { FactoryGirl.create(:user) }

  describe "GET show" do
    it "fetches a single user" do
      get :show, :id => user.id
      JSON.parse(response.body)["id"].should == user.id
    end
  end
end
