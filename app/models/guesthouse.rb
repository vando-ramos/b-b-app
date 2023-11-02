class Guesthouse < ApplicationRecord
  belongs_to :full_address
  belongs_to :payment_method
end
