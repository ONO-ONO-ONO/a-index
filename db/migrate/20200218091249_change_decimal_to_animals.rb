class ChangeDecimalToAnimals < ActiveRecord::Migration[5.2]
  def up
    change_column :animals, :min_length, :float
    change_column :animals, :max_length, :float
    change_column :animals, :min_weight, :float
    change_column :animals, :max_weight, :float
  end
end
