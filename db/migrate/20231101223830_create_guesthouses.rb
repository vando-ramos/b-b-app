class CreateGuesthouses < ActiveRecord::Migration[7.1]
  def change
    create_table :guesthouses do |t|
      t.string :brand_name
      t.string :corporate_name
      t.string :register_number
      t.string :phone_number
      t.string :email
      t.string :description
      t.string :pet_friendly
      t.string :terms
      t.datetime :check_in_time
      t.datetime :check_out_time
      t.string :status
      t.references :full_address, null: false, foreign_key: true
      t.references :payment_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end
