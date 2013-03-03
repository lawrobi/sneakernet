class Api::MessagesController < ApplicationController

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
    if @message.from_user_id = current_user
      if @message.update_attributes(params[:message])
        render json: @message.to_json(:include => [:from_user, :to_user])
      else
        head :no_content
      end
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy if @message.from_user_id = current_user
  end

  def show
    @message = Message.find(params[:id])
    render json: @message.to_json(:include => [:from_user, :to_user])
  end
end
