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

  config.sort_order = 'marca_asc'

  filter :marca, as: :select, collection: Marca.select_options
  filter :modelo
  filter :realizado#, as: :check_boxes
  filter :fecha_realizado

  show do
    attributes_table do
        row("Marca") { |b| status_tag b.marca }
        row :modelo
        row :descripcion
        row :serie
        row :horas
        row :anios
        row :encargado
      end
    end

  index do
    selectable_column
    column("Marca", :sortable => :marca) {|maquina| status_tag maquina.marca.text}
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
