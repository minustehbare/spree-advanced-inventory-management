class CreatePurchaseOrders < ActiveRecord::Migration
  def self.up
    create_table :purchase_orders do |t|
      t.column :order_number, :string
      t.column :sent_at, :date
      t.column :received_at, :date
      t.column :supplier_id, :integer
      t.column :state, :string
    end
  end

  def self.down
    drop_table :purchase_orders
  end
end
