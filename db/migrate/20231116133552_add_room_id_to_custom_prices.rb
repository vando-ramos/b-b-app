class AddRoomIdToCustomPrices < ActiveRecord::Migration[7.1]
  def change
    add_reference :custom_prices, :room, null: false, foreign_key: true
  end
end
