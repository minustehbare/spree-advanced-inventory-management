class ProductLocation < ActiveRecord::Base
  belongs_to :warehouse_location
  belongs_to :product
end
