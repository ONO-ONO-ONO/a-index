class AddRedlistToColumns < ActiveRecord::Migration[5.2]
  def up
    add_column :redlists, :red_list_full_name, :string, :after => :red_list_name
  end
  def down
    remove_column :redlists, :red_list_full_name, :string, :after => :red_list_name
  end
end
