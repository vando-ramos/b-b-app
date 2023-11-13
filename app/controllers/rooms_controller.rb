class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_guesthouse
  before_action :set_room, only: [:edit, :update]

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

  def edit
    if @room.guesthouse == @guesthouse
      render :edit
    else
      redirect_to root_path, alert: "You don't have permission to edit this room!"
    end
  end

  def update
    @room = set_guesthouse.rooms.find(params[:id])

    if @room.update(room_params)
      redirect_to @guesthouse, notice: 'Room updated successfully!'
    else
      flash.now.alert = 'Unable to update the room!'
      render :edit, status: :unprocessable_entity
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

def set_room
  @room = @guesthouse.rooms.find_by(id: params[:id])

  unless @room
    redirect_to @guesthouse, alert: "You don't have permission to edit this room!"
  end
end
