class CreateProductLocations < ActiveRecord::Migration
  def self.up
    create_table :product_locations do |t|
      t.column :warehouse_id, :integer
      t.column :aisle, :string
      t.column :row, :string
      t.column :bin, :string
    end
  end

  def self.down
    drop_table :product_locations
  end
end
