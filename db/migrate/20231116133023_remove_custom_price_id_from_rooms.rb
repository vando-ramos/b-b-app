class RemoveCustomPriceIdFromRooms < ActiveRecord::Migration[7.1]
  def change
    remove_reference :rooms, :custom_price, null: false, foreign_key: true
  end
end
