class RenameColumnsToAnimals < ActiveRecord::Migration[5.2]
  def change
    rename_column :animals, :class, :animal_class
    rename_column :animals, :order, :animal_order
    rename_column :animals, :family, :animal_family
    rename_column :animals, :genus, :animal_genus
    rename_column :animals, :species, :animal_species
    add_column :animals, :animal_sub_species, :string
  end
end