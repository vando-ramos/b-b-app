class CreateGuesthousePaymentMethods < ActiveRecord::Migration[7.1]
  def change
    create_table :guesthouse_payment_methods do |t|
      t.references :guesthouse, null: false, foreign_key: true
      t.references :payment_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end
