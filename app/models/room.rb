class Room < ApplicationRecord
  belongs_to :custom_price
  belongs_to :guesthouse

  has_many :room_amenities
  has_many :amenities, through: :room_amenities

  accepts_nested_attributes_for :custom_price
end
