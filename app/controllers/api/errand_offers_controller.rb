class Api::ErrandOffersController < Api::ApplicationController

  def index
    @errand_offers = ErrandOffer.joins(:errand)
    if params[:minimum_distance].present?
      @errand_offers = @errand_offers.where("errands.distance >= (?)",
                                            params[:minimum_distance])
    end
    if params[:maximum_distance].present?
      @errand_offers = @errand_offers.where("errands.distance <= (?)",
                                            params[:maximum_distance])
    end
    if params[:size].present?
      @errand_offers = @errand_offers.where("errands.size = (?)", params[:size])
    end
    if params[:status].present?
      @errand_offers = @errand_offers.where("status = (?)", params[:status])
    end
    # min and max delivery time params are in *hours*
    if params[:minimum_delivery_time].present?
      @errand_offers.reject! { |eo| eo.arriving_at - eo.leaving_at <=                                                           params[:minimum_delivery_time].to_i*60*60 }
    end
    if params[:maximum_delivery_time].present?
      @errand_offers.reject! { |eo| eo.arriving_at - eo.leaving_at >=                                                           params[:maximum_delivery_time].to_i*60*60 }
    end
    render json: @errand_offers.to_json(include_hash)
  end

  def create
    @errand_offer = ErrandOffer.new(params[:errand_offer])
    @errand_offer.courier_id = current_user.id
    @errand_offer.save!
    render json: @errand_offer.to_json(include_hash)
  end

  def update
    @errand_offer = ErrandOffer.find(params[:id])
    if @errand_offer.courier_id = current_user.id
      if @errand_offer.update_attributes(params[:errand_offer])
        render json: @errand_offer.to_json(include_hash)
      else
        head :no_content
      end
    end
  end

  def destroy
    @errand_offer = ErrandOffer.find(params[:id])
    @errand_offer.destroy if @errand_offer.courier_id == current_user.id
    head :no_content
  end

  def show
    @errand_offer = ErrandOffer.find(params[:id])
    render json: @errand_offer.to_json(include_hash)
  end

private
  def include_hash
    {:include => :errand}
  end
end
