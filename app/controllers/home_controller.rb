class HomeController < ApplicationController
  def index
    if user_signed_in?
      @guesthouses = Guesthouse.ativa.or(Guesthouse.where(user_id: current_user.id))
    else
      @guesthouses = Guesthouse.ativa
    end
  end
end
