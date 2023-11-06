class GuesthousesController < ApplicationController
  def index
    @guesthouses = Guesthouse.all
  end

  def new
    @guesthouse = Guesthouse.new
  end

  def create
    @guesthouse = Guesthouse.new(guesthouse_params)

    selected_payment_methods = PaymentMethod.find(params[:guesthouse][:payment_method_ids])
    @guesthouse.payment_methods << selected_payment_methods

    if @guesthouse.save
      redirect_to @guesthouse, notice: 'Guesthouse registered successfully!'
    else
      flash.now.alert = 'Unable to register guesthouse!'
      render :new
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
end
