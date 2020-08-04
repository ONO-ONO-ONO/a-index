class AddColumnToAccountOfDevise < ActiveRecord::Migration[5.2]
  def up
    add_column :accounts, :confirmation_token, :string
    add_column :accounts, :confirmed_at, :datetime
    add_column :accounts, :confirmation_sent_at, :datetime
    add_column :accounts, :unconfirmed_email , :string
  end
  def down
    remove_column :accounts, :confirmation_token, :string
    remove_column :accounts, :confirmed_at, :datetime
    remove_column :accounts, :confirmation_sent_at, :datetime
    remove_column :accounts, :unconfirmed_email , :string
  end
end
