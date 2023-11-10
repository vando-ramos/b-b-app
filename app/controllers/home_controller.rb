class HomeController < ApplicationController
  def index
    @users = User.all
    @guesthouses = Guesthouse.all
  end
end
