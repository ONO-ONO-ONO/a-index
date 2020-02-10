class AddColumnAnimal < ActiveRecord::Migration[5.2]
  def change
    add_column :animals, :created_user, :integer
    add_column :animals, :updated_user, :integer
    add_column :animals, :name, :string, null: false
    add_column :animals, :binomial_name, :string
    add_column :animals, :class, :string
    add_column :animals, :order, :string
    add_column :animals, :family, :string
    add_column :animals, :genus, :string
    add_column :animals, :species, :string
    add_column :animals, :length, :decimal
    add_column :animals, :weight, :decimal
  end
end
