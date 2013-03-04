require 'spec_helper'

describe Api::MessagesController do
  let(:message) { FactoryGirl.create(:message) }
  let(:other_user) { FactoryGirl.create(:user) }

  describe "GET index" do
    it "retrieves messages for current user" do
      sign_in message.to_user
      get :index
      messages = JSON.parse(response.body)
      messages.count.should == 1
      messages.first["id"].should == message.id
    end
  end

  describe "POST create" do
    it "creates a new message" do
      sign_in message.to_user
      post :create, {:message => {:to_user_id => other_user.id }}
      m = JSON.parse(response.body)
      m["to_user_id"].should == other_user.id
      other_user.inbox.first.id.should == m["id"]
    end

    it "fails when no user logged in" do
      post :create, {:message => {:to_user_id => other_user.id }}
      response.status.should == 401
    end
  end

  describe "PUT update" do
    it "updates an existing message" do
      sign_in message.to_user
      message.body.should_not == "Stewie"
      put :update, :id => message.id, :message => {:body => "Stewie"}
      m = JSON.parse(response.body)
      m["id"].should == message.id
      m["body"].should == "Stewie"
      message.reload.body.should == "Stewie"
    end

    it "fails when no user logged in" do
      put :update, :id => message.id, :message => {:body => "Stewie"}
      response.status.should == 401
    end
  end

  describe "DELETE destroy" do
    it "destroys an existing message" do
      sign_in message.to_user
      delete :destroy, :id => message.id
      response.should be_success
      Message.find_by_id(message.id).should be_nil
    end

   it "fails when no user logged in" do
      delete :destroy, :id => message.id
      response.status.should == 401
    end
  end

  describe "GET show" do
    it "fetches a single message" do
      sign_in message.to_user
      get :show, :id => message.id
      JSON.parse(response.body)["id"].should == message.id
    end
  end
end
