class Admin::PurchaseOrdersController < Admin::BaseController
  resource_controller
    
  before_filter :load_data, :only => [:new, :edit, :create, :update]
  #before_filter :check_state, :only => [:edit]
  
  def new
    @purchase_order = PurchaseOrder.create
  end

  edit.after do
    flash[:error] = "Cannot re-assign Supplier. Delete purchase order and start over."
  end
  
  create.response do |wants|
    wants.html { redirect_to '/admin/purchase_orders/' + @purchase_order.number + '/edit' }
  end
  
  destroy.after :recalulate_totals
  update.after :recalulate_totals, :set_state
  create.after :recalulate_totals
  
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
  
  def set_state
    @purchase_order.receive if params[:submit][:receive]
  end
  
  def object
    @object ||= PurchaseOrder.find_by_number(params[:id])
  end

  def recalulate_totals
    @purchase_order.update_totals
  end
  
  #def check_state
  #  @purchase_order = PurchaseOrder.find_by_param(params[:id])
  #  if @purchase_order.state == "done"
  #    flash[:error] = "Cannot modify a closed purchase order, your argument is invalid, bitches."
  #    redirect_to '/admin/purchase_orders/' + @purchase_order.number
  #  end
  #end
end
