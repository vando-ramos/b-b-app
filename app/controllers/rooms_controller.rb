class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_guesthouse
  before_action :set_room, only: %i[show edit update]

  def new
    @room = @guesthouse.rooms.build
  end

  def create
    @room = @guesthouse.rooms.build(room_params)

    if @room.save
      redirect_to @guesthouse, notice: 'Room registered successfully!'
    else
      flash.now.alert = 'Unable to register room!'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @custom_prices = CustomPrice.all
  end

  def edit
    unless @room && current_user == @guesthouse.user
      flash.alert = "You don't have permission to edit this room!"
      redirect_to guesthouse_path
    end
  end

  def update
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
    amenity_ids: []
  )
end

def set_guesthouse
  @guesthouse = current_user.guesthouse
end

def set_room
  return if @guesthouse.nil?
  @room = @guesthouse.rooms.find_by(id: params[:id])
end
