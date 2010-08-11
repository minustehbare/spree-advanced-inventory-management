class CreateProductLocations < ActiveRecord::Migration
  def self.up
    create_table :product_locations do |t|
      t.column :warehouse_id, :integer
      t.column :name, :string
      t.column :parent_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :product_locations
  end
end
