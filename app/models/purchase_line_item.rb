class PurchaseLineItem < ActiveRecord::Base
  belongs_to :purchase_order
  belongs_to :variant
  
  has_one :product, :through => :variant
  
end
