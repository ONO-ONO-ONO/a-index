class ChangeAccountsColumnsIndexEmail < ActiveRecord::Migration[5.2]
  def up
    remove_index :accounts, [:email]
  end

  def down
    add_index :accounts, :email, unique: true
  end
end
