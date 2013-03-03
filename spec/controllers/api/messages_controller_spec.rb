require 'spec_helper'

describe Api::MessagesController do
  let(:message) { FactoryGirl.create(:message) }
  let(:other_user) { FactoryGirl.create(:user) }

  before { sign_in message.to_user }

  describe "GET index" do
    it "retrieves messages for current user" do
      get :index
      messages = JSON.parse(response.body)
      messages.count.should == 1
      messages.first["id"].should == message.id
    end
  end

  describe "POST create" do
    it "creates a new message" do
      post :create, {:message => {:to_user_id => other_user.id }}
      m = JSON.parse(response.body)
      m["to_user_id"].should == other_user.id
      other_user.inbox.first.id.should == m["id"]
    end
  end

  describe "PUT update" do
    it "updates an existing message" do
      message.body.should_not == "Stewie"
      put :update, :id => message.id, :message => {:body => "Stewie"}
      m = JSON.parse(response.body)
      m["id"].should == message.id
      m["body"].should == "Stewie"
      message.reload.body.should == "Stewie"
    end
  end

  describe "DELETE destroy" do
    it "destroys an existing message" do
      delete :destroy, :id => message.id
      response.should be_success
      Message.find_by_id(message.id).should be_nil
    end
  end

  describe "GET show" do
    it "fetches a single message" do
      get :show, :id => message.id
      JSON.parse(response.body)["id"].should == message.id
    end
  end
end
