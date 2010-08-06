require File.dirname(__FILE__) + '/../test_helper'

class AdvancedInventoryManagementExtensionTest < Test::Unit::TestCase
  
  # Replace this with your real tests.
  def test_this_extension
    flunk
  end
  
  def test_initialization
    assert_equal File.join(File.expand_path(Rails.root), 'vendor', 'extensions', 'advanced_inventory_management'), AdvancedInventoryManagementExtension.root
    assert_equal 'Advanced Inventory Management', AdvancedInventoryManagementExtension.extension_name
  end
  
end
