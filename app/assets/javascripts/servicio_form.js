$(function() {
	insumos_de_maquina($("#servicio_maquina_id").val());
	$("#servicio_maquina_id").change(function(){
		insumos_de_maquina($(this).val());
	})
});

function insumos_de_maquina(maquina_id) {
    if(!maquina_id)
      return;

    $.ajax({
      type: "POST",
      url: "/ajax/insumos_de_maquina",
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      data: { maquina_id: maquina_id }
    }).done(function(data){
      //alert(JSON.stringify(data));

      //Primero levanto los existentes y me guardo cuales son los checked
      var checked = Array();
      $("input[name='servicio[insumo_ids][]']:checked").each(function(){
        checked.push($(this).val());
      });

      //Vacio todas las opciones
      $(".choices-group").empty();

      //Cargo las opciones correspondientes a la maquina seleccionada
      $.each(data, function(key, i){
        $(".choices-group").append('<li class="choice"><label for="servicio_insumo_ids_'+i.id+'"><input type="checkbox" name="servicio[insumo_ids][]" id="servicio_insumo_ids_'+i.id+'" value="'+i.id+'">'+i.to_s+'</label></li>');
      });

      //Vuelvo a tildar los insumos que estaban tildados
      checked.forEach(function(id){
        var chequear = $("#servicio_insumo_ids_"+id);
        if( chequear )
          chequear.click();
      });

      /* close loading */
      //$("#ajax-loader-container").hide();
    })
}