class RenamePositionColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :position, :role
  end
end
