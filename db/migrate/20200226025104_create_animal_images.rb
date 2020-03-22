class CreateAnimalImages < ActiveRecord::Migration[5.2]
  def change
    create_table :animal_images do |t|
      t.integer :animal_id
      t.string :image

      t.timestamps
    end
  end
end
