class CreateCustomPrices < ActiveRecord::Migration[7.1]
  def change
    create_table :custom_prices do |t|
      t.string :daily_price
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
