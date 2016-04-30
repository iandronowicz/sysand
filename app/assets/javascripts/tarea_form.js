$(function() {
	//deshabilito los precios totales ya que los voy a calcular automaticamente
	//$("input[id$='_precio_total']").prop('disabled', true);

	$(document).on("keyup", "input[id$='_cantidad'], input[id$='_precio_unitario']", function(){
		//validar que sea un numero
		var splitted_array = $(this).attr("id").split("_");
		
		splitted_array.pop();
		if($(this).attr("id").indexOf("precio") >= 0)
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
	});
});