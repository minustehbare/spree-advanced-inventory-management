class CreatePurchaseLineItems < ActiveRecord::Migration
  def self.up
    create_table :purchase_line_items do |t|
      t.column :purchase_order_id, :integer
      t.column :product_id, :integer
      t.column :qty, :integer
      t.column :cost_paid, :decimal
    end
  end

  def self.down
    drop_table :purchase_line_items
  end
end
