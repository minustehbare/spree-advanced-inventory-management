class CreateSupplierChannels < ActiveRecord::Migration
  def self.up
    create_table :supplier_channels do |t|
      t.column :product_id, :integer
      t.column :supplier_id, :integer
      t.column :cost, :decimal
      t.column :supplier_sku, :string
    end
  end

  def self.down
    drop_table :supplier_channels
  end
end
