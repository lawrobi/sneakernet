require 'spec_helper'

describe Api::MessagesController do
  let(:message) { FactoryGirl.create(:message) }

  before { sign_in message.to_user }

  describe "GET index" do
    it "retrieves messages for current user" do
      get :index
      messages = JSON.parse(response.body)
      messages.count.should == 1
      messages.first["id.should"] == message.id
    end
  end
end
