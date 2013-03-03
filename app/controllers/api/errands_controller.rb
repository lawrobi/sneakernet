class Api::ErrandsController < ApplicationController

  def index
    @errands = Errand.all
    render json: @errands.to_json
  end

  def create
    @errand = Errand.new(params[:errand])
    @errand.requester_id = current_user.id
    @errand.save!
    render json: @errand.to_json
  end

  def update
    @errand = Errand.find(params[:id])
    if @errand.requester_id = current_user.id
      if @errand.update_attributes(params[:errand])
        render json: @errand.to_json
      else
        head :no_content
      end
    end
  end

  def destroy
    @errand = Errand.find(params[:id])
    @errand.destroy if @errand.requester_id = current_user.id
    head :no_content
  end

  def show
    @errand = Errand.find(params[:id])
    render json: @errand.to_json
  end

end
