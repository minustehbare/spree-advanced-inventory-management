class SupplierChannel < ActiveRecord::Base
  belongs_to :variant
  belongs_to :supplier
end
