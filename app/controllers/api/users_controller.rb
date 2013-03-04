class Api::UsersController < ApplicationController
  def show
    @user = User.includes(:requested_errands => :errand_offers)
                .includes(:errand_offers_as_courier).find(params[:id])
    requests_completed = @user.requested_errands.select do |e|
      e.errand_offers.find {|eo| eo.status == "completed" }
    end
    requests_pending = @user.requested_errands - requests_completed
    errand_offers_completed = @user.errand_offers_as_courier.select do |eo|
      eo.status == "completed"
    end
    errand_offers_pending = @user.errand_offers_as_courier -
                            errand_offers_completed
    render json: @user.attributes.merge(
      :requests_completed => requests_completed,
      :requests_pending => requests_pending,
      :errand_offers_completed => errand_offers_completed,
      :errand_offers_pending => errand_offers_pending,
      :large_image_url => @user.large_image_url
    ).to_json
  end

end
