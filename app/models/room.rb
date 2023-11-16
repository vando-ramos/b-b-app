class Room < ApplicationRecord
  belongs_to :guesthouse

  has_many :custom_prices
  has_many :room_amenities
  has_many :amenities, through: :room_amenities

  validates :name, :description, :maximum_guests, :dimension, :daily_price, :status, presence: true

  enum status: { disponivel: 'Disponível', indisponivel: 'Indisponível' }
end
