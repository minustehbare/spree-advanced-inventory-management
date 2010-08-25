class Admin::ProductLocationsController < Admin::BaseController
  resource_controller
  before_filter :load_data, :only => [:index, :remove]
  belongs_to :product
  
  def remove
    ProductLocation.destroy(params[:id])
    render :layout => false
  end

  private
  def load_data
    @product = parent_object
  end
  
  def object
    @object ||= Product.find_by_permalink(params[:product_id])
  end
  
  def collection
    @search = end_of_association_chain
    @collection = @search.find(:all, :include => :warehouse_location)
  end
end
