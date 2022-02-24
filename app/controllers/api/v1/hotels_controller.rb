class Api::V1::HotelsController < ApplicationController
  def index
    @city = City.find(params[:city_id])
    @hotels = @city.hotels.all
    render json: @hotels.to_json(
      include: :city, except: :city_id
    )
  end
end
