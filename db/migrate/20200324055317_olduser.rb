class Olduser < ActiveRecord::Migration[5.2]
  def change
    rename_table :users, :old_users
  end
end
