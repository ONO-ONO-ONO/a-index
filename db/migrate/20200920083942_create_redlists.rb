class CreateRedlists < ActiveRecord::Migration[5.2]
  def change
    create_table :redlists do |t|
      t.string :red_list_name, null: false
      t.string :red_list_details, null: false

      t.timestamps
    end
  end
end
