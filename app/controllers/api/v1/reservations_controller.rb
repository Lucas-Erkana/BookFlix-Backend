class Api::V1::ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
    render json: @reservations
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      render json: @reservation, status: 200
    else
      render json: {
        error: 'Error creating reservation...'
      }
    end
  end

  def reservation_params
    params.require(:reservation).permit(:location_id, :user_id, :service_id, :start_date, :end_date)
  end

  def new
    @reservation = Reservation.new
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
  end
end
