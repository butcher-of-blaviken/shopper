class Favourites < ActiveRecord::Migration[5.1]
  def change
    create_table :favourites do |t|
      t.integer :user_id
      t.integer :product_id
    end

    add_index :favourites, [:user_id, :product_id]
  end
end
