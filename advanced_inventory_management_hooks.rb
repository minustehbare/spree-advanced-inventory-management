class AdvancedInventoryManagementHooks < Spree::ThemeSupport::HookListener

  insert_after :admin_tabs do
    "<%= tab(:purchase_orders) %>"
  end

end
