class PaymentMethod < ApplicationRecord
  has_many :guesthouse_payment_methods
  has_many :guesthouses, through: :guesthouse_payment_methods
end
