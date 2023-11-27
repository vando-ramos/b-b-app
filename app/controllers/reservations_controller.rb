class ReservationsController < ApplicationController
  def new
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.build
  end

  def create
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.build(reservation_params)

    if @reservation.valid? && @room.available?(@reservation.start_date, @reservation.end_date, @reservation.num_guests)
      @total_price = @reservation.total_price
      render :show_total_price
    else
      flash.now.alert = 'Sorry, the room is not available for the selected dates or does not have enough capacity for the number of guests.'
      render 'new'
    end
  end

  def show_total_price
    @total_price = @reservation.total_price
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :num_guests, :status)
  end
end
