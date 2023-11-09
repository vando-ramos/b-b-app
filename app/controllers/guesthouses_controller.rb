class GuesthousesController < ApplicationController
  before_action :set_guesthouse, only: %i[show edit update]

  def index
    @guesthouses = Guesthouse.all
    @payment_methods = PaymentMethod.all
  end

  def new
    @guesthouse = Guesthouse.new
  end

  def create
    @guesthouse = Guesthouse.new(guesthouse_params)

    if @guesthouse.save
      redirect_to @guesthouse, notice: 'Guesthouse registered successfully!'
    else
      flash.now.alert = 'Unable to register guesthouse!'
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
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
