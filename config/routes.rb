# Put your extension routes here.

map.namespace :admin do |admin|
  admin.resources :purchase_orders, :has_many => [:purchase_line_items]
  admin.resources :suppliers
  
  admin.resources :products, :collection => {:products_by_supplier => :get}
end
