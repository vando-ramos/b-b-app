class FullAddress < ApplicationRecord
  belongs_to :guesthouse

  accepts_nested_attributes_for :guesthouse
end
