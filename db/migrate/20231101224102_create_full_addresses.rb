class CreateFullAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :full_addresses do |t|
      t.string :address
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :zip_code

      t.timestamps
    end
  end
end
