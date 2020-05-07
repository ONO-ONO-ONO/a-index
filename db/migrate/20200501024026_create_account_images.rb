class CreateAccountImages < ActiveRecord::Migration[5.2]
  def change
    create_table :account_images do |t|
      t.integer :account_id
      t.string :avatar

      t.timestamps
    end
  end
end
