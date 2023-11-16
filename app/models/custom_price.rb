class CustomPrice < ApplicationRecord
  belongs_to :room

  validate :no_date_overlap

  private

  def no_date_overlap
    if room.custom_prices.where.not(id: id).exists?(['(start_date <= ? AND end_date >= ?)
      OR (start_date <= ? AND end_date >= ?)', start_date, start_date, end_date, end_date])
      errors.add(:base, 'There should be no overlapping dates')
    end
  end
end
