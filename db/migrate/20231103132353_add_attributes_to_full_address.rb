class AddAttributesToFullAddress < ActiveRecord::Migration[7.1]
  def change
    add_column :full_addresses, :number, :integer
    add_column :full_addresses, :complement, :string
  end
end
