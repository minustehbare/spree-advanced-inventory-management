class Supplier < ActiveRecord::Base
  has_many :supplier_channels, :products
end
