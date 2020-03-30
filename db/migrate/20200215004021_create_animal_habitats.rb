class CreateAnimalHabitats < ActiveRecord::Migration[5.2]
  def change
    create_table :animal_habitats do |t|
      t.integer :animal_id
      t.string :habitat

      t.timestamps
    end
  end
end
