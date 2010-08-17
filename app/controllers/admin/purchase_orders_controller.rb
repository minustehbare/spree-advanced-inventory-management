class Admin::PurchaseOrdersController < Admin::BaseController
  resource_controller
    
  before_filter :load_data, :only => [:new, :edit, :create, :update]
  
  def new
    @purchase_order = PurchaseOrder.create
  end

  edit.after do
    flash[:error] = "Cannot re-assign Supplier. Delete purchase order and start over."
  end
  
  create.response do |wants|
    wants.html { redirect_to '/admin/purchase_orders/' + @purchase_order.number + '/edit' }
  end
  
  def show
    @purchase_order = PurchaseOrder.find(params[:id])
    @purchase_order.get_total
  end
  
  private

  def load_data
    @suppliers = Supplier.all.collect{|x| [x.name, x.id]}
  end

  def collection
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
