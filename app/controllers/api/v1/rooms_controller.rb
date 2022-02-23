class Api::V1::RoomsController < ApplicationController
  def index
    @rooms = Room.all
    render json: @rooms.to_json(
      include: { hotel: {
        include: :city, except: :id
      } }, except: [:hotel_id]
    )
  end

  def show
    @room = Room.find(params[:id])
    render json: @room.to_json(
      include: { hotel: {
        include: :city, except: :id
      } }, except: [:hotel_id]
    )
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      render json: {
        success: 'The room was created succesfully'
      }
    else
      render json: {
        error: 'The room was not created'
      }
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.update(deleted: true)
  end

  private

  def room_params
    params.permit(:description, :image, :price, :people_amount, :hotel_id)
  end
end
