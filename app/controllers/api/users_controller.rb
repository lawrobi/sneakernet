class Api::UsersController < ApplicationController
  def show
    @user = User.includes(:requested_errands => :errand_offers)
                .includes(:errand_offers_as_courier).find(params[:id])
    render json: @user.to_json(:methods => [:requested_errands_completed,
      :requested_errands_pending, :errand_offers_completed,
      :errand_offers_pending, :large_image_url])
  end

  def requested_errands
    @user = User.includes(:requested_errands => :errand_offers).find(params[:id])
    render json: {:requested_errands_completed => @user.requested_errands_completed.as_json(:include => [:errand_offers => {:include => :courier}]), :requested_errands_pending => @user.requested_errands_pending.as_json(:include => [:errand_offers => {:include => :courier}])}
  end

  def accepted_errands
    @user = User.includes(:errand_offers_as_courier).find(params[:id])
    errands_completed = @user.errand_offers_completed.map {|eo| eo.errand}
    errands_pending = @user.errand_offers_pending.map {|eo| eo.errand}
    render json: {
      :accepted_errands_completed =>
        errands_completed.as_json(:include =>
          [:requester, :errand_offers => {:include => :courier}]),
      :accepted_errands_pending =>
        errands_pending.as_json(:include =>
          [:requester, :errand_offers => {:include => :courier}])
    }
  end
end
