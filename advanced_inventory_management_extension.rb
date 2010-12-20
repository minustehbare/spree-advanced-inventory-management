# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class AdvancedInventoryManagementExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/advanced_inventory_management"
  
  def activate

    Admin::ProductsController.class_eval do
      def products_by_supplier

        includes = [{:variants => :images}, :master, :images]
        @collection = Product.name_contains(params[:q]).supplier_channels_supplier_id_eq(params[:supplier_id]).all(:include => includes, :limit => 10)
                
        respond_to do |wants|
          wants.json {
            render :json => @collection.to_json(:include => {:master => {}, :variants => {:include => {:images => {}}}, :images => {}})
            }
        end
      end
    end

    Product.class_eval do
      has_many :product_locations, :dependent => :destroy
      has_many :supplier_channels
      has_many :suppliers, :through => :supplier_channels
      
      has_one :default_supplier_channel, :class_name => "SupplierChannel", :conditions => "supplier_channels.is_default = 1"
      
      has_one :default_supplier, :class_name => "Supplier", :through => :default_supplier_channel
      
      def cost_price 
        default_supplier_channel.cost if default_supplier_channel
      end
    end
    
    Order.class_eval do
    
      state_machine do
        after_transition :to => 'paid', :do => [:make_shipments_ready, :check_if_reorder_needed]
      end
      
      def check_if_reorder_needed
        PurchaseOrder.check_if_reorder_needed(products)
      end
      
    end
 
  end
end
