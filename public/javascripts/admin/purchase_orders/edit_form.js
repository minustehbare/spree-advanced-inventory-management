jQuery(document).ready(function(){
  $.each($('td.qty input'), function(i, inpt){
    $(inpt).delayedObserver(0.5, function(object, value) {

      var id = object.attr('id').replace("purchase_order_line_items_attributes_", "").replace("_quantity", "");
      id = "#purchase_order_line_items_attributes_" + id + "_id";

      jQuery.ajax({
        type: "POST",
        url: "/admin/purchase_orders/" + $('input#purchase_order_number').val() + "/purchase_line_items/" + $(id).val(),
        data: ({_method: "put", "line_item[quantity]": value}),
        success: function(html){ $('#purchase_order-form-wrapper').html(html)}
      });

    });
  });
});
