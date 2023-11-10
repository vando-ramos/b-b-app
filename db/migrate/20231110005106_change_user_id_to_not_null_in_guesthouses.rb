class ChangeUserIdToNotNullInGuesthouses < ActiveRecord::Migration[7.1]
  def change
    change_column_null :guesthouses, :user_id, false
  end
end
