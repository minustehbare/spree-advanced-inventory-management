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
        @collection = Product.name_contains(params[:q]).master_supplier_channels_supplier_id_eq(params[:supplier_id]).all(:include => includes, :limit => 10)
                
        respond_to do |wants|
          wants.json {
            render :json => @collection.to_json(:include => {:master => {}, :variants => {:include => {:images => {}}}, :images => {}})
            }
        end
      end
    end
    
    Variant.class_eval do
    
      has_many :supplier_channels  
      
    end
 
  end
end
