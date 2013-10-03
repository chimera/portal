class AddIndexOnRfidCodeOnUsers < ActiveRecord::Migration
  def change
    add_index :users, :rfid_code
  end
end
