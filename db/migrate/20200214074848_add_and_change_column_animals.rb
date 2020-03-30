class AddAndChangeColumnAnimals < ActiveRecord::Migration[5.2]
  def change
    rename_column :animals, :length, :min_length
    rename_column :animals, :weight, :min_weight
    add_column :animals, :max_length, :decimal
    add_column :animals, :max_weight, :decimal
    add_column :animals, :detail, :text
    add_column :animals, :classification, :string
    add_column :animals, :deleted_at, :datetime
  end
end
