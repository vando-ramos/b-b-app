class HomeController < ApplicationController
  def index
    @guesthouses = Guesthouse.ativa
  end
end
