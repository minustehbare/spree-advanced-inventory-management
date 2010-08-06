class PurchaseOrder < ActiveRecord::Base
  has_many :purchase_line_items
end
