class Api::V1::LocationsController < ApplicationController
  def index
    @locations = Location.all
    render json: @locations
  end

  def create
    @location = Location.new(location_params)

    if @location.save
      render json: @location, status: 200
    else
      render json: {
        error: 'Error creating location...'
      }
    end
  end

  def location_params
    params.require(:location).permit(:name)
  end
end
