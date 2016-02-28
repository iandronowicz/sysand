ActiveAdmin.register Maquina do
  permit_params :marca, :modelo, :descripcion, :serie, :horas, :anio, :encargado_id
  
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
    column "Id", :sortable => :id do |maquina|
      link_to maquina.id, admin_maquina_path(maquina)
    end
    column("Marca", :sortable => :marca) {|maquina| maquina.marca.text}
    column :modelo
    column :descripcion
    column :serie
    column :horas
    column :anio
    column :encargado
    actions
  end

  form do |f|
    f.inputs do
      f.input :marca, :as => :select, :collection => Marca.select_options, :include_blank => false
      f.input :modelo
      f.input :descripcion
      f.input :serie
      f.input :horas
      f.input :anio
      f.input :encargado
    end
    f.actions
  end
  
end
