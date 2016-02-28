ActiveAdmin.register MovimientoDeInsumo do
  permit_params :insumo_id, :reparacion_id, :tipo_de_movimiento, :cantidad, :descripcion
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  form do |f|
    f.inputs do
      f.input :insumo
      f.input :reparacion
      f.input :tipo_de_movimiento, :as => :select, :collection => TipoDeMovimiento.select_options, :include_blank => false, :selected => TipoDeMovimiento::Salida
      f.input :cantidad
      f.input :descripcion
    end
    f.actions
  end
  
end
