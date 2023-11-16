class CustomPricesController < ApplicationController
  before_action :set_room

  def new
    @custom_price = @room.custom_prices.build
  end

  def create
    @custom_price = @room.custom_prices.new(custom_price_params)

    if @custom_price.save
      redirect_to @room, notice: 'Custom price set successfully!'
    else
      flash.now.alert = 'Unable to set custom price!'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def custom_price_params
    params.require(:custom_price).permit(:daily_price, :start_date, :end_date)
  end
end
