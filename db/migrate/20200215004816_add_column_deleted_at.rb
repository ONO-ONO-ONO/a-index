class AddColumnDeletedAt < ActiveRecord::Migration[5.2]
  def change
    add_column :animal_distributions, :deleted_at, :datetime
    add_column :animal_habitats, :deleted_at, :datetime
  end
end
