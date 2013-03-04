class Api::MessagesController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :update, :destroy]

  def index
    @messages = Message.to_user(current_user) 
    render json: @messages.to_json(:include => [:from_user, :to_user])
  end

  def create
    @message = Message.new(params[:message])
    @message.from_user_id = current_user.id
    @message.save!
    render json: @message.to_json(:include => [:from_user, :to_user])
  end

  def update
    @message = Message.find(params[:id])
    if @message.from_user_id = current_user.id
      if @message.update_attributes(params[:message])
        render json: @message.to_json(:include => [:from_user, :to_user])
      else
        head :no_content
      end
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy if @message.from_user_id = current_user.id
    head :no_content
  end

  def show
    @message = Message.find(params[:id])
    render json: @message.to_json(:include => [:from_user, :to_user])
  end
end
