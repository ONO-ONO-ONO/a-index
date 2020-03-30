class CreateAnimalDistributions < ActiveRecord::Migration[5.2]
  def change
    create_table :animal_distributions do |t|
      t.integer :animal_id
      t.string :distribution

      t.timestamps
    end
  end
end
