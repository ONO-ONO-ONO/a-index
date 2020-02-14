class AddAndChangeColumnAnimals2 < ActiveRecord::Migration[5.2]
  def change
    add_column :animals, :red_list, :string
  end
end
