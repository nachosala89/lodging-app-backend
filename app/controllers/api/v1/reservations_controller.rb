class Api::V1::ReservationsController < ApplicationController
  def index
    @reservations = current_user.reservations
    render json: @reservations.to_json(
      :include => { :room => {
        :include => { :hotel => {
          :include => :city, :except => :id
        } } , :except => [:hotel_id]
      } }, :except => [:room_id, :user_id]
    )
  end

  def show
    @reservation = Reservation.find(params[:id])
    render json: @reservation.to_json(
      :include => { :room => {
        :include => { :hotel => {
          :include => :city, :except => :city_id
        } } , :except => [:hotel_id]
      } }, :except => [:room_id, :user_id]
    )
  end

  def create
    @reservation = current_user.reservations.new(reservation_params)
    if @reservation.save
      render json: {
        success: 'The reservation was created succesfully'
      }
    else
      render json: {
        error: 'The reservation was not created'
      }
    end
  end

  private

  def reservation_params
    params.permit(:check_in_date, :check_out_date, :room_id)
  end
end
