class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :maximum_guests
      t.string :description
      t.string :dimension
      t.string :daily_price
      t.string :status
      t.references :custom_price, null: false, foreign_key: true

      t.timestamps
    end
  end
end
