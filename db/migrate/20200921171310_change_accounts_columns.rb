class ChangeAccountsColumns < ActiveRecord::Migration[5.2]
  def up
    change_column :accounts, :email, :string, null: true
  end

  def down
    change_column :accounts, :email, :string, null: false
  end
end
