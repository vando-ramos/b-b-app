class HomeController < ApplicationController
  before_action :load_guesthouses, only: [:index, :guesthouses_by_city]

  def index
    @recent_guesthouses = @guesthouses.ativa.order(created_at: :desc).limit(3)
    @other_guesthouses = other_guesthouses

    @cities = cities_with_guesthouses
  end

  def guesthouses_by_city
    @city = params[:city]
    @guesthouses = @guesthouses.ativa.joins(:full_address).where(full_addresses: { city: @city }).order(:brand_name)
  end

  private

  def load_guesthouses
    @guesthouses =
      if user_signed_in?
        Guesthouse.all.or(Guesthouse.where(user_id: current_user.id))
      else
        Guesthouse.all
      end
  end

  def other_guesthouses
    if user_signed_in?
      @guesthouses.ativa.where.not(id: @recent_guesthouses.pluck(:id)).or(Guesthouse.where(user_id: current_user.id))
    else
      @guesthouses.ativa.where.not(id: @recent_guesthouses.pluck(:id))
    end.uniq
  end

  def cities_with_guesthouses
    @guesthouses.ativa.joins(:full_address).pluck(:city).compact.uniq
  end
end
