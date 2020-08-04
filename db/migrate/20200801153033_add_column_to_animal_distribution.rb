class AddColumnToAnimalDistribution < ActiveRecord::Migration[5.2]
  def up
    rename_column :animal_distributions, :distribution, :distribution_1
    add_column :animal_distributions, :distribution_2, :string, :after => :distribution_1
    add_column :animal_distributions, :distribution_3, :string, :after => :distribution_2
    add_column :animal_distributions, :distribution_4, :string, :after => :distribution_3
    add_column :animal_distributions, :distribution_5, :string, :after => :distribution_4
  end
  def down
    rename_column :animal_distributions, :distribution_1, :distribution
    remove_column :animal_distributions, :distribution_2, :string, :after => :distribution_1
    remove_column :animal_distributions, :distribution_3, :string, :after => :distribution_2
    remove_column :animal_distributions, :distribution_4, :string, :after => :distribution_3
    remove_column :animal_distributions, :distribution_5, :string, :after => :distribution_4
  end
end
