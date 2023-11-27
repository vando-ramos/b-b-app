class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.references :room, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :num_guests
      t.string :status

      t.timestamps
    end
  end
end
