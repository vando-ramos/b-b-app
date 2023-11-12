class GuesthousesController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :set_guesthouse, only: %i[show edit update]

  def new
    if current_user.guesthouse.present?
      flash.alert = 'You already have a registered guesthouse.'
      redirect_to current_user.guesthouse
    else
      @guesthouse = current_user.build_guesthouse
    end
  end

  def create
    @guesthouse = current_user.build_guesthouse(guesthouse_params)

    if @guesthouse.save
      redirect_to @guesthouse, notice: 'Guesthouse registered successfully!'
    else
      flash.now.alert = 'Unable to register guesthouse!'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @rooms = @guesthouse.rooms
  end

  def edit
    unless current_user == @guesthouse.user
      flash.alert = "You don't have permission to edit this guesthouse."
      redirect_to guesthouse_path
    end
  end

  def update
    if @guesthouse.update(guesthouse_params)
      redirect_to @guesthouse, notice: 'Guesthouse updated successfully!'
    else
      flash.now.alert = 'Unable to update the guesthouse'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def guesthouse_params
    params.require(:guesthouse).permit(
      :brand_name,
      :corporate_name,
      :register_number,
      :phone_number,
      :email,
      :description,
      :pet_friendly,
      :terms,
      :check_in_time,
      :check_out_time,
      :status,
      full_address_attributes: [:address, :number, :neighborhood, :city, :state, :zip_code, :complement],
      payment_method_ids: []
      )
  end

  def set_guesthouse
    @guesthouse = Guesthouse.find(params[:id])
  end
end
