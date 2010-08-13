class Admin::PurchaseLineItemsController < Admin::BaseController
  resource_controller
  belongs_to :purchase_order
  ssl_required
  actions :all, :except => :index

  create.flash nil
  update.flash nil
  destroy.flash nil

  #override r_c create action as we want to use order#add_variant instead of creating line_item
  def create
    load_object
    variant = Variant.find(params[:line_item][:variant_id])

    before :create

    @purchase_order.add_variant(variant, params[:line_item][:quantity].to_i)

    if @purchase_order.save
      after :create
      set_flash :create
      response_for :create
    else
      after :create_fails
      set_flash :create_fails
      response_for :create_fails
    end

  end

  destroy.success.wants.html { render :partial => "admin/purchase_orders/form", :locals => {:order => @purchase_order}, :layout => false }
  destroy.failure.wants.html { render :partial => "admin/purchase_orders/form", :locals => {:order => @purchase_order}, :layout => false }

  new_action.response do |wants|
    wants.html {render :action => :new, :layout => false}
  end

  create.response do |wants|
    wants.html { render :partial => "admin/purchase_orders/form", :locals => {:order => @purchase_order}, :layout => false}
  end

  update.success.wants.html { render :partial => "admin/purchase_orders/form", :locals => {:order => @purchase_order}, :layout => false}
  update.failure.wants.html { render :partial => "admin/purchase_orders/form", :locals => {:order => @purchase_order}, :layout => false}

  #destroy.after :recalulate_totals
  #update.after :recalulate_totals
  #create.after :recalulate_totals

  private
  def recalulate_totals
    unless @purchase_order.shipping_method.nil?
      @purchase_order.shipping_charges.each do |shipping_charge|
        shipping_charge.update_attributes(:amount => @purchase_order.shipping_method.calculate_cost(@purchase_order.shipment))
      end
    end

    @purchase_order.tax_charges.each do |tax_charge|
      tax_charge.update_attributes(:amount => tax_charge.calculate_tax_charge)
    end

    @purchase_order.update_totals!

    unless @purchase_order.in_progress?
      InventoryUnit.adjust_units(@purchase_order)
    end
  end
end
