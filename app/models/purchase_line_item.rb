class PurchaseLineItem < ActiveRecord::Base
  belongs_to :purchase_order, :product, :through => :variant
end
