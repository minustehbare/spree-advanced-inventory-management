class WarehouseLocation < ActiveRecord::Base
  belongs_to :warehouse
  belongs_to :parent, :class_name => 'WarehouseLocation'
  has_many :children, :class_name => 'WarehouseLocation', 
           :foreign_key => 'parent_id', 
           :dependent => :destroy
end
