class GuesthousesController < ApplicationController
  before_action :authenticate_user!

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
      render :new
    end
  end

  def show
    @guesthouse = Guesthouse.find(params[:id])
    @payment_methods = PaymentMethod.all
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

  # def check_user_type

  # end
end
