ActiveAdmin.register MovimientoDeInsumo do
  permit_params :insumo_id, :tipo_de_movimiento, :cantidad, :descripcion, :servicio_id
  
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

  scope :all, :default => true

  scope :entrada do |movimientosdeinsumos|
    movimientosdeinsumos.where(tipo_de_movimiento: TipoDeMovimiento[:entrada].to_s)
  end

  scope :salida do |movimientosdeinsumos|
    movimientosdeinsumos.where(tipo_de_movimiento: TipoDeMovimiento[:salida].to_s)
  end

  index do
    selectable_column
    column :insumo
    column("Tipo", :sortable => :tipo_de_movimiento) {|tdm| tdm.tipo_de_movimiento.text}
    column :cantidad
    column :descripcion
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :insumo
      f.input :tipo_de_movimiento, :as => :select, :collection => TipoDeMovimiento.select_options, :include_blank => false, :default => TipoDeMovimiento::Salida
      f.input :cantidad
      f.input :descripcion
      f.input :servicio
    end
    f.actions
  end
  
end
