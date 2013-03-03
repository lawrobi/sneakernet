class Api::OffersController < ApplicationController
  def index
    @offers = Offer.all
    render json: @offers.to_json
  end

  def create
    @offer = Offer.new(params[:offer])
    @offer.courier_id = current_user.id
    @offer.save!
    render json: @offer.to_json
  end

  def update
    @offer = Offer.find(params[:id])
    if @offer.courier_id = current_user.id
      if @offer.update_attributes(params[:offer])
        render json: @offer.to_json
      else
        head :no_content
      end
    end
  end

  def destroy
    @offer = Offer.find(params[:id])
    @offer.destroy if @offer.courier_id = current_user.id
    head :no_content
  end

  def show
    @offer = Offer.find(params[:id])
    render json: @offer.to_json
  end

end
