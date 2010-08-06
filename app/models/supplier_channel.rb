class SupplierChannel < ActiveRecord::Base
  belongs_to :supplier, :variant
end
