class Warehouse < ActiveRecord::Base
  has_many :product_locations
end
