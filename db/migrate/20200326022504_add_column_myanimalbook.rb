class AddColumnMyanimalbook < ActiveRecord::Migration[5.2]
  def change
    add_column :my_animal_books, :my_animal_image, :string , null: false
  end
end
