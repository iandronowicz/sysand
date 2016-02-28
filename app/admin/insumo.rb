ActiveAdmin.register Insumo do
  permit_params :tipo_de_insumo, :codigo, :descripcion, :stock, :reemplaza_insumo_id
  
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

  index do
    selectable_column
    column "Id", :sortable => :id do |insumo|
      link_to insumo.id, admin_insumo_path(insumo)
    end
    column("Tipo", :sortable => :tipo_de_insumo) {|insumo| insumo.tipo_de_insumo.text}
    column :codigo
    column :stock
    column :descripcion
    column("Usado en") { |insumo| insumo.cantidad_de_maquinas_que_lo_usan }
    actions
  end

  form do |f|
    f.inputs do
      f.input :tipo_de_insumo, :as => :select, :collection => TipoDeInsumo.select_options, :include_blank => false
      f.input :codigo
      f.input :descripcion
      f.input :stock
      if f.object.new_record?
        f.input :reemplaza_insumo
      else
        f.input :reemplaza_insumo, :as => :select, :collection => Insumo.where("id != #{f.object.id}").collect { |v| [v, v.id] }, :include_blank => true
      end
    end
    f.actions
  end
  
end
