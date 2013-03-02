class Api::MessagesController < ApplicationController

  def index
    @comments = Comment.all
    render json: @commetns.to_json
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.image_id = params[:image_id]
    @comment.user_id = current_user.id
    @comment.save!
    render json: @comment
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.user = current_user
      if @comment.update_attributes(params[:comment])
        render json: @comment
      else
        head :no_content
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy if @comment.user = current_user
  end

  def show
    @comment = Comment.find(params[:id])
    render json: @comment
  end
end
