class GuesthousesController < ApplicationController
  def index
    @guesthouses = Guesthouse.all
  end
end
