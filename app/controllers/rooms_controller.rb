class RoomsController < ApplicationController
  before_action :authenticate_user!

  def new
    @room = set_guesthouse.rooms.build
    @room.build_custom_price
  end

  def create
    @room = set_guesthouse.rooms.build(room_params)

    if @room.save
      redirect_to @guesthouse, notice: 'Room registered successfully!'
    else
      flash.now.alert = 'Unable to register room!'
      render :new, status: :unprocessable_entity
    end
  end
end

private

def room_params
  params.require(:room).permit(
    :name,
    :description,
    :maximum_guests,
    :dimension,
    :daily_price,
    :status,
    custom_price_attributes: [:daily_price, :start_date, :end_date],
    amenity_ids: []
  )
end

def set_guesthouse
  @guesthouse = current_user.guesthouse
end
