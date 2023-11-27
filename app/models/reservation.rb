class Reservation < ApplicationRecord
  belongs_to :room

  validates :start_date, :end_date, :num_guests, presence: true
  validate :availability, on: :create

  def total_price
    return unless start_date && end_date

    days = (end_date - start_date).to_i
    room.daily_price.to_i * days
  end

  private

  def availability
    return unless start_date && end_date && num_guests

    existing_reservations = room.reservations.where.not(id: id).where.not(status: 'cancelled')
    overlapping_reservations = existing_reservations.where('(start_date <= ? AND end_date >= ?) OR (start_date <= ? AND end_date >= ?)', start_date, start_date, end_date, end_date)

    if overlapping_reservations.any?
      errors.add(:base, 'Room not available for the selected dates')
    end

    if num_guests > room.maximum_guests
      errors.add(:guests, 'Number of guests exceeds room capacity')
    end
  end
end
