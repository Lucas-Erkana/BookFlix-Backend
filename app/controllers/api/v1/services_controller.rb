class Api::V1::ServicesController < ApplicationController
  def index
    @services = Service.all
    render json: @services
  end

  def show
    render json: @service
  end

  def create
    @service = Service.new(service_params)

    if @service.save
      render json: @service, status: 200
    else
      render json: {
        error: 'Error creating service...'
      }
    end
  end

  def destroy
    @service = Service.find(params[:id])
    @service.destroy
    head :no_content
  end

  private

  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:name, :price, :image, :details, :duration, :rating, :trailer)
  end
end
