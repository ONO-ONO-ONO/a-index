class AddAccountsColumnRundomPass < ActiveRecord::Migration[5.2]
  def up
    add_column :accounts, :ex_temporary_registration, :boolean, default: false
    add_column :accounts, :random_timepass, :string
  end
  def down
    remove_column :accounts, :ex_temporary_registration, :boolean
    remove_column :accounts, :random_timepass, :string
  end
end
