class DropGuesthousePaymentMethods < ActiveRecord::Migration[7.1]
  def change
    drop_table :guesthouse_payment_methods
  end
end
