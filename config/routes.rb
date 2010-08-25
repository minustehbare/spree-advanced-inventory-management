# Put your extension routes here.

map.namespace :admin do |admin|
  admin.resources :purchase_orders, :has_many => [:purchase_line_items]
  admin.resources :suppliers
  
  admin.resources :products, :collection => {:products_by_supplier => :get}

  admin.resources :products do |product|
    product.resources :supplier_channels, :member => {:set_default => :get}
    product.resources :product_locations, :member => {:remove => :post}
  end

end
