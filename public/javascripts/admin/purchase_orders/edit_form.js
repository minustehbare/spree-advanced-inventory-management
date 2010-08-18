jQuery(document).ready(function(){
  $.each($('td.qty input'), function(i, inpt){
    $(inpt).delayedObserver(2, function(object, value) {

      var id = object.attr('id').replace("purchase_order_purchase_line_items_attributes_", "").replace("_qty", "");
      id = "#purchase_order_purchase_line_items_attributes_" + id + "_id";

      jQuery.ajax({
        type: "POST",
        url: "/admin/purchase_orders/" + $('input#purchase_order_number').val() + "/purchase_line_items/" + $(id).val(),
        data: ({_method: "put", "purchase_line_item[qty]": value}),
        success: function(html){ $('#purchase_order-form-wrapper').html(html)}
      });

    });
  });
  $.each($('td.cost input'), function(i, inpt){
    $(inpt).delayedObserver(2, function(object, value) {

      var id = object.attr('id').replace("purchase_order_purchase_line_items_attributes_", "").replace("_cost", "");
      id = "#purchase_order_purchase_line_items_attributes_" + id + "_id";

      jQuery.ajax({
        type: "POST",
        url: "/admin/purchase_orders/" + $('input#purchase_order_number').val() + "/purchase_line_items/" + $(id).val(),
        data: ({_method: "put", "purchase_line_item[cost]": value}),
        success: function(html){ $('#purchase_order-form-wrapper').html(html)}
      });

    });
  });
});
