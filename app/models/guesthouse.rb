class Guesthouse < ApplicationRecord
  belongs_to :full_address, dependent: :destroy
  belongs_to :user

  has_many :guesthouse_payment_methods, dependent: :destroy
  has_many :payment_methods, through: :guesthouse_payment_methods

  accepts_nested_attributes_for :full_address

  validates :brand_name, :corporate_name, :register_number, :phone_number, :email, :description, :pet_friendly,
  :terms, :check_in_time, :check_out_time, :status, :payment_method_ids, presence: true

  validates :register_number, uniqueness: true
end
