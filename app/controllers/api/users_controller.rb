class Api::UsersController < ApplicationController
  def show
    @user = User.includes(:requested_errands => :errand_offers)
                .includes(:errand_offers_as_courier).find(params[:id])
    render json: @user.to_json(:methods => [:requested_errands_completed,
      :requested_errands_pending, :errand_offers_completed,
      :errand_offers_pending, :large_image_url])
  end

  def requested_errands
    @user = User.includes(:requested_errands => {:errand_offers => :courier}).find(params[:id])
    render json: @user.requested_errands.to_json(:methods => :status, :include => [:errand_offers => {:include => :courier}])
  end

  def accepted_errands
    @user = User.includes(:errand_offers_as_courier => {:errand => :requester}).find(params[:id])
    errands = @user.errand_offers_as_courier.map {|eo| eo.errand}
    render json:
        errands.to_json(:methods => :status, :include =>
          [:requester, :errand_offers => {:include => :courier}])
  end
end
