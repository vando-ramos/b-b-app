class FullAddress < ApplicationRecord
  validates :address, :number, :neighborhood, :city, :state, :zip_code, presence: true
end
