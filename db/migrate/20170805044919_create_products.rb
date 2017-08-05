class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.integer :alcohol_content
      t.text :description
      t.integer :inventory_count
      t.integer :inventory_price_in_cents
      t.integer :inventory_volume_in_milliliters
      t.string :name
      t.string :origin
      t.text :package
      t.string :package_unit_type
      t.integer :package_unit_volume_in_milliliters
      t.integer :price_in_cents
      t.string :primary_category
      t.integer :regular_price_in_cents
      t.string :style
      t.string :image_url
      t.string :image_thumb_url
      t.string :tags
      t.string :varietal
      t.integer :volume_in_milliliters

      t.timestamps
    end
  end
end

