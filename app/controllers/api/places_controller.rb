class Api::PlacesController < ApplicationController
  def show
    @place = Place.find(params[:id])
    render json: @place.to_json
  end
end
