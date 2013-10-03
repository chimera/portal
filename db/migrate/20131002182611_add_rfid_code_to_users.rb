class AddRfidCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rfid_code, :string
  end
end
