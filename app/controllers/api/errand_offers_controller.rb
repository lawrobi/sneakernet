class Api::ErrandOffersController < ApplicationController
  def create
    @errand_offer = ErrandOffer.new(params[:errand_offer])
    @errand_offer.courier_id = current_user.id
    @errand_offer.save!
    render json: @errand_offer.to_json
  end
end
