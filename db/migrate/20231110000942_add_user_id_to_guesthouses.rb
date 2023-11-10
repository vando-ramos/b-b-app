class AddUserIdToGuesthouses < ActiveRecord::Migration[7.1]
  def change
    add_reference :guesthouses, :user, foreign_key: true

    change_column_null :guesthouses, :user_id, true
  end
end
