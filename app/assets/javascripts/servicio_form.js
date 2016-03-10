$(function() {
	servicio_maquina_insumos($("#servicio_maquina_id").val());
	$("#servicio_maquina_id").change(function(){
		servicio_maquina_insumos($("#servicio_maquina_id").val());
	})
});

function servicio_maquina_insumos(maquina_id) {
    $.ajax({
      type: "POST",
      url: "/home/servicio_maquina_insumos",
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      data: { maquina_id: maquina_id }
    }).done(function(data){
      //alert(data);
    });
}