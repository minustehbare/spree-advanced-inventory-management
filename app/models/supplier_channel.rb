class SupplierChannel < ActiveRecord::Base
  belongs_to :supplier, :product
end
