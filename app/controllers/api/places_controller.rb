class Api::PlacesController < ApplicationController
  def show
    @place = Place.find(params[:id])
    render json: @place.to_json
  end

  def index
    @places = Place.scoped
    if params[:q]
      @places = @places.where("display_name like ?", "%#{params[:q]}%")                                .order("population desc").take(10)
    end
    render json: @places.to_json
  end
end
