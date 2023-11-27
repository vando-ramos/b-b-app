class Room < ApplicationRecord
  belongs_to :guesthouse

  has_many :custom_prices
  has_many :room_amenities
  has_many :amenities, through: :room_amenities
  has_many :reservations

  validates :name, :description, :maximum_guests, :dimension, :daily_price, :status, presence: true

  enum status: { disponivel: 'Disponível', indisponivel: 'Indisponível' }

  def available?(start_date, end_date, num_guests)
    reservations = Reservation.where(room: self)
                             .where.not(status: 'canceled')
                             .where('(start_date <= ? AND end_date >= ?) OR (start_date <= ? AND end_date >= ?)', start_date, start_date, end_date, end_date)

    total_guests = reservations.sum(:num_guests)

    available_capacity = maximum_guests - total_guests

    return available_capacity >= num_guests
  end
end
