class RemovePaymentMethodIdFromGuesthouses < ActiveRecord::Migration[7.1]
  def change
    remove_column :guesthouses, :payment_method_id, :integer
  end
end
