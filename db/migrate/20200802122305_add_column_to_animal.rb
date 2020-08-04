class AddColumnToAnimal < ActiveRecord::Migration[5.2]
  def up
    add_column :animals, :distribution_1, :string
    add_column :animals, :distribution_2, :string
    add_column :animals, :distribution_3, :string
    add_column :animals, :distribution_4, :string
    add_column :animals, :distribution_5, :string
    add_column :animals, :habitat_1, :string
    add_column :animals, :habitat_2, :string
    add_column :animals, :habitat_3, :string
    add_column :animals, :habitat_4, :string
    add_column :animals, :habitat_5, :string
  end
  def down
    remove_column :animals, :distribution_1, :string
    remove_column :animals, :distribution_2, :string
    remove_column :animals, :distribution_3, :string
    remove_column :animals, :distribution_4, :string
    remove_column :animals, :distribution_5, :string
    remove_column :animals, :habitat_1, :string
    remove_column :animals, :habitat_2, :string
    remove_column :animals, :habitat_3, :string
    remove_column :animals, :habitat_4, :string
    remove_column :animals, :habitat_5, :string
  end
end
