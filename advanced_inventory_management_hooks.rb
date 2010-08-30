class AdvancedInventoryManagementHooks < Spree::ThemeSupport::HookListener

  insert_after :admin_tabs do
    "<%= tab(:purchase_orders) %>"
  end
  
  insert_after(:admin_product_tabs) do
    '<% if url_options_authenticate?(:controller => "admin/supplier_channels") %>
      <li<%= \' class="active"\' if current == "Supplier Channels" %>>
        <%= link_to t("supplier_channels"), admin_product_supplier_channels_path(@product) %>
      </li>
    <% end %>'
  end
  
  insert_after(:admin_product_tabs) do
    '<% if url_options_authenticate?(:controller => "admin/product_locations") %>
      <li<%= \' class="active"\' if current == "Inventory" %>>
        <%= link_to t("inventory"), admin_product_product_locations_path(@product) %>
      </li>
    <% end %>'
  end
  
  insert_after(:admin_inside_head) do
    '<link href="/stylesheets/admin/inventory-styles.css" media="screen" rel="stylesheet" type="text/css" /> '
  end

  insert_after :admin_product_form_right , "admin/products/supplier_fields"

end
