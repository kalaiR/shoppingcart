(function ($, settings) {
	var form_shoppingCart = $("#shoppingCart"),
		shopping_cart = $("#shoppingCart"),
		basket_list = shopping_cart.find(".basket_list"),
		remove_all = shopping_cart.find(".remove_all"),
		remove_item_btns = basket_list.find("td.remove > .btn"),
		size_selects = basket_list.find("td.size > select"),
		color_selects = basket_list.find("td.color > select"),
		qty_inputs = basket_list.find("td.quantity > input"),
		delivery_radios = basket_list.find(".delivery_block input[name='deliveryOption']"),
		add_item_btns = basket_list.find(".additional_empty td.empty_td > .btn"),
		checkout_btns = shopping_cart.find(".continue_to_checkout"),
		promotion_add = $("#promotionAdd"),
		promotion_percent = 0,
		basket_total_block = $("#basketTotalsList");


	function prepareAllSettings() {

		// set currency
		basket_list.find(".currency").html(settings.currency);

		// set taxes
		basket_total_block.find(".taxes_percent").html(settings.taxes);

		// set discount
		basket_total_block.find(".discount_percent").html(settings.discount);

		// calculate subtotals
		basket_list.find(".table").not(".table_header").each(function () {
			$(this).find("tr").not(".additional_empty").each(function () {
				calculateSubtotal($(this));
			});
		});

	};



	function recalculateTotalBlock() {
		var subtotals = basket_list.find(".table .subtotal > .amount"),
			sum = 0,
			taxes,
			delivery,
			discount,
			total,
			taxes_block = basket_total_block.find(".basket_taxes > .amount"),
			discount_block = basket_total_block.find(".basket_discount > .amount"),
			delivery_block = basket_total_block.find(".basket_delivery > .amount"),
			goods_subtotal = basket_total_block.find(".basket_subtotal > .amount"),
			order_total = basket_total_block.find(".basket_total .amount");

		subtotals.each(function () {
			sum += $(this).text() * 1;
		});

		taxes = (settings.taxes * sum) / 100;
		taxes_block.text(taxes.toFixed(2));

		delivery = $("input[name='deliveryOption']:checked").val() * 1;
		delivery_block.text(delivery.toFixed(2));

		discount = ((settings.discount + promotion_percent) * sum) / 100;
		discount_block.text(discount.toFixed(2));

		goods_subtotal.text(sum.toFixed(2));

		if (sum !== 0) {
			total = sum + taxes + delivery - discount;
		} else {
			total = 0;
		}
		order_total.text(total.toFixed(2));
	}

	function calculateSubtotal(item) {
		var qty = item.find("input.number").val(),
			price = item.find(".price > .amount").text(),
			subtotal = item.find(".subtotal > .amount"),
			multiply;

		if (validateForm(item) === true && !isNaN(qty)) {
			multiply = (qty * price).toFixed(2);
		} else {
			multiply = "0.00";
		}

		subtotal.text(multiply);

		recalculateTotalBlock();
	}

	 function removeAllItems() {

		// TODO - send your ajax request for removing all items from the basket
		$.ajax({
			type: 'POST',
			url: 'ajax_fakes/remove_all.html',
		data: null,
			success: function () {

				basket_list.find(".table").remove();
				basket_list.find(".empty_basket").show();
				remove_all.addClass("disabled");
				remove_all.tooltip("destroy");
			checkout_btns.addClass("disabled");

				recalculateTotalBlock();
			}
		});
	}

	function gatherProductObject(parent_table) {
		var obj = {};

		parent_table.find("tr").not(".additional_empty").each(function () {

			var size_name = $(this).find("td.size select, td.size input").attr("id").split("_")[1],
				size_val = $(this).find("td.size select, td.size input").val(),
				color_name =  $(this).find("td.color select, td.color input").attr("id").split("_")[1],
				color_val =  $(this).find("td.color select, td.color input").val(),
				qty_name =  $(this).find("td.quantity input").attr("id").split("_")[1],
				qty_val =  $(this).find("td.quantity input").val();

			if (validateForm($(this), "hidden") === true) {
				obj[size_name] = size_val;
				obj[color_name] = color_val;
				obj[qty_name] = qty_val;
			}
		});

		return obj;
	}

	function checkSameItem(row) {

		var parent_table = row.parents("table"),
			size0 = row.find("td.size select, td.size input").val(),
			color0 = row.find("td.color select, td.color input").val(),
			qty0 = row.find("td.quantity input").val();

		parent_table.find("tr").not(".additional_empty").each(function () {
			var size, color, qty;

			if (validateForm(row) ===  true && validateForm($(this)) === true) {
				if ($(this).get(0) != row.get(0)) {

					size = $(this).find("td.size select, td.size input").val();
					color = $(this).find("td.color select, td.color input").val();
					qty = $(this).find("td.quantity input").val();

					if (size === size0 && color === color0) {

						$(this).find("td.quantity input").val((qty*1 + qty0*1).toString());

						removeItem(row.find("td.remove > .btn"));
						calculateSubtotal($(this));

						return false;
					}
				}
			}
		});
	}

	function removeItem(item) {
		var parent_table = item.parents("table"),
			parent_row = item.parents("tr.warning"),
			first_row = parent_table.find("tr:first"),
			second_additional = parent_table.find("tr.additional:eq(0)"),
			prod = parent_table.find(".item-sku").text(),
			data_obj = {};

		item.tooltip("destroy");

		if (parent_row.hasClass("additional")) {
			parent_row.remove();
			first_row.find("td:lt(2)").attr("rowspan", parent_table.find("tr").length);

			data_obj = gatherProductObject(parent_table);
		} else {
			if (second_additional.length) {
				second_additional.find("td.size").before(first_row.find("td:lt(2)"));
				second_additional.removeClass("additional");
				first_row.remove();
				second_additional.find("td:lt(2)").attr("rowspan", parent_table.find("tr").length);

				data_obj = gatherProductObject(parent_table);
			} else {
				parent_table.remove();
				if (!basket_list.find(".tables > .table").not(".table_header").length) {
					removeAllItems();
				}

				data_obj = {};
			}
		}

		data_obj.prod = prod;

		// TODO - send your ajax request for removing item from the basket
		$.ajax({
			type: 'POST',
			url: 'ajax_fakes/remove_item.html',
			data: data_obj,
			success: function () {
				recalculateTotalBlock();
			}
		});
	}

	function addItem(item) {
		var parent_table = item.parents("table"),
			first_row = parent_table.find("tr:first"),
			last_row = parent_table.find("tr").not(".additional_empty").last(),
			new_row = last_row.clone();

		new_row.css("visibility", "hidden");
		if (new_row.hasClass("additional")) {
			// do nothing
		} else {
			new_row.find("td.thumb, td.description").remove();
			new_row.addClass("additional");
		}

		parent_table.find(".additional_empty").before(new_row.css("visibility", "visible"));
		first_row.find("td:lt(2)").attr("rowspan", parent_table.find("tr").length);

		new_row.find(".btn[rel='tooltip']")
			.tooltip("hide")
			.click(function () {
				removeItem($(this));
			});

		 new_row.find("select, input").each(function () {
		 	var name = $(this).attr("name");
				name_arr = name.split("_");
		 	name_item_text = name_arr[1].replace(/\d/g, "");
				name_item_number = name_arr[1].replace(/\D/g, "");
			name_item_number++;
		 	name_arr[1] = name_item_text + name_item_number;
		 	name = name_arr.join("_");
			$(this).attr("name", name);
		 	$(this).attr("id", name);
		});

		new_row.find("input.number").val("1");
		new_row.find("td.subtotal .amount").text("0.00");
		new_row.find("select").each(function () {
			$(this)[0].selectedIndex = 0;
		});
		new_row.find("> td").removeClass("error");

	}

	 function validateForm(context, visibility) {
	 	var result = true,
 		context = context;

	 	if (!context) context = form_shoppingCart;

	 	if (visibility !== "hidden") {
	 		$("select, input", context).parent().removeClass("error");
	 	}

	 	$("select", context).each(function () {
	 		if ($(this).val() === "0") {

	 			if (visibility !== "hidden") {
	 				$(this).parent().addClass("error");
	 			}

	 			result = false;
	 		}
	 	});

		$("input.number", context).each(function () {
			var input_val = $(this).val();
			if (input_val === "0" || input_val.replace(/\d/g, "") !== "") {

				if (visibility !== "hidden") {
					$(this).parent().addClass("error");
				}

				result = false;
			}
		});

		return result;
	}

	function setAllHandlers() {
		remove_all.click(function () {
			removeAllItems();
		});

		remove_item_btns.click(function () {
			removeItem($(this));
		});

		add_item_btns.click(function () {
			addItem($(this));
		});

		shopping_cart.submit(function () {
			return false;
		});

		 checkout_btns.click(function () {
			if (validateForm() === true) {

				// TODO - send your ajax request for checkout
		 		$.ajax({
				type:'POST',
					url:'ajax_fakes/checkout.html',
					data: null,
					success:function () {}
				});
			}
		});

		delivery_radios.change(function () {

			// TODO - send your ajax request for choosing delivery plan
			$.ajax({
				type: 'POST',
				url: 'ajax_fakes/choose_delivery.html',
				data: null,
				success: function () {
					recalculateTotalBlock();
				}
			});
		});

		qty_inputs.change (function () {
			var parent_row = $(this).parents("tr"),
				parent_table = parent_row.parents("table"),
				prod = parent_table.find(".item-sku").text(),
				data_obj = {};

			checkSameItem(parent_row);

			data_obj = gatherProductObject(parent_table);
			data_obj.prod = prod;

			// TODO - send your ajax request for choosing quantity of item
			$.ajax({
				type:'POST',
				url:'ajax_fakes/choose_qty.html',
				data: data_obj,
				success:function () {
					calculateSubtotal(parent_row);
				}
			});
		});

		size_selects.change( function () {
			var parent_row = $(this).parents("tr"),
				parent_table = parent_row.parents("table"),
				prod = parent_table.find(".item-sku").text(),
				data_obj = {};

			checkSameItem(parent_row);

			data_obj = gatherProductObject(parent_table);
			data_obj.prod = prod;

			// TODO - send your ajax request for choosing size of item
			$.ajax({
				type:'POST',
				url:'ajax_fakes/choose_size.html',
				data: data_obj,
				success:function () {
					calculateSubtotal(parent_row);
				}
			});
		});

		color_selects.change(function () {
			var parent_row = $(this).parents("tr"),
				parent_table = parent_row.parents("table"),
				prod = parent_table.find(".item-sku").text(),
				data_obj = {};

			checkSameItem(parent_row);

			data_obj = gatherProductObject(parent_table);
			data_obj.prod = prod;

			// TODO - send your ajax request for choosing color of item
			$.ajax({
				type:'POST',
				url:'ajax_fakes/choose_color.html',
				data: data_obj,
				success:function () {
					calculateSubtotal(parent_row);
				}
			});
		});

		promotion_add.click(function () {
			var promo_code = $.trim($("#appendedInputButton").val());

			if (promo_code === "") {
				promotion_percent = 0;
				basket_total_block.find(".discount_percent").text(settings.discount);

				recalculateTotalBlock();
				return false;
			}

			// TODO - send your ajax request for validating promo code
			$.ajax({
				type: 'POST',
				url: 'ajax_fakes/promotion.txt',
				complete: function (data) {

					var saving = data.responseText * 1;

					// example of response:
					// 10
					if (!isNaN(saving)) {
						promotion_percent = saving;
						basket_total_block.find(".discount_percent").text(settings.discount + promotion_percent);

						recalculateTotalBlock();
					}
				}
			});
		});
	}

	function initAllTooltips() {
		// init promotional tooltip
		promotion_add.tooltip('hide');

		// init Remove All tooltip
		remove_all.tooltip("hide");

		// init Remove Item tooltip
		remove_item_btns.tooltip("hide");
	};

	function init () {
		prepareAllSettings();
		initAllTooltips();
		setAllHandlers();
	};

	return init();

}(window.jQuery, {

	// TODO - default settings
	currency: "&pound;",
	taxes: 5,
	discount: 2
}));