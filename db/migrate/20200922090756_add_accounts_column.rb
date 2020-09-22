class AddAccountsColumn < ActiveRecord::Migration[5.2]
  def up
    add_column :accounts, :ex_status, :boolean, default: false
  end
  def down
    remove_column :accounts, :ex_status, :boolean
  end
end
