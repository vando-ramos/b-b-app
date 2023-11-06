class Guesthouse < ApplicationRecord
  belongs_to :full_address

  has_many :guesthouse_payment_methods
  has_many :payment_methods, through: :guesthouse_payment_methods

  accepts_nested_attributes_for :full_address
end
