class Admin::PurchaseOrdersController < Admin::BaseController
  resource_controller
    
  before_filter :load_data, :only => [:new, :edit, :create, :update]

  new_action.response do |wants|
    wants.html {render :action => :new, :layout => false}
  end
  
  edit.after do
    flash[:error] = "Cannot re-assign Supplier. Delete purchase order and start over."
  end
  
  create.response do |wants|
    wants.html { redirect_to collection_url }
  end

  private

  def load_data
    @suppliers = Supplier.all.collect{|x| [x.name, x.id]}
  end

  def collection
#    @search = end_of_association_chain
#    @collection = @search.find(:all, :include => [:purchase_line_items, :supplier])
    @search = PurchaseOrder.searchlogic(params[:search])
    @search.order ||= "descend_by_created_at"

    @collection = @search.paginate(:include  => [:supplier, :purchase_line_items],
                                   :per_page => 30,
                                   :page     => params[:page])
  end
  
  def object
    @object ||= PurchaseOrder.find_by_number(params[:id])
  end

end
