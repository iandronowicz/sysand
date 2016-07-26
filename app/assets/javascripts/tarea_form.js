$(function() {
	//deshabilito los precios totales ya que los voy a calcular automaticamente
	$("input[id$='_precio_total']").prop("readonly", true);

	$(document).on("keyup change", "input[id$='_cantidad'], input[id$='_precio_unitario']", function(){
		recalculatePrices($(this));
	});

	$(document).on("click", ".has_many_add", function(){
		$("input[id$='_precio_total']").prop("readonly", true);
	});

	$(document).on("change", "select[id$='_tipo_de_tarea_id']", function(){
		var splitted_text = $("#"+$(this).attr("id")+" option:selected").text().split("|");
		var price = 0;
		if(splitted_text.length > 1) {
			var formatted_price = splitted_text[1];
			price = formatted_price.substring(2, formatted_price.length-1).replace(',', '');
		}
		var trabajo_index = $(this).attr("id").split("_")[3];
		$("#trabajo_tareas_attributes_"+trabajo_index+"_precio_unitario").attr('value', price);
		$("#trabajo_tareas_attributes_"+trabajo_index+"_precio_unitario").change();
	});
});

function recalculatePrices(self) {
	//validar que sea un numero
	var splitted_array = self.attr("id").split("_");

	splitted_array.pop();
	if(self.attr("id").indexOf("precio") >= 0)
		splitted_array.pop();
	splitted_array.push("precio_total");
	var total_id = splitted_array.join("_");

	splitted_array.pop();
	splitted_array.push("precio_unitario");
	var unitario_id = splitted_array.join("_");

	splitted_array.pop();
	splitted_array.push("cantidad");
	var cantidad_id = splitted_array.join("_");

	var cantidad = parseFloat($("#"+cantidad_id).val());
	cantidad = (isNaN(cantidad)?0:cantidad);
	var unitario = parseFloat($("#"+unitario_id).val());
	unitario = (isNaN(unitario)?0:unitario);
	$("#"+total_id).val(cantidad*unitario);
}