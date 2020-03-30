class CreateMyAnimalBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :my_animal_books do |t|
      t.integer :user_id,          null: false
      t.string :my_animal_name,    null: false
      t.string :my_animal_place
      t.text :my_animal_detail
      t.integer :check,            null: false,   default: 0

      t.timestamps
    end
  end
end
