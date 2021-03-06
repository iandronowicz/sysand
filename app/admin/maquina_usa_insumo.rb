ActiveAdmin.register MaquinaUsaInsumo do
  permit_params :maquina_id, :insumo_id, :cantidad, :descripcion
  menu priority: 5
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

  config.sort_order = 'maquina_id_asc'

  filter :maquina
  filter :insumo

  show do
    attributes_table do
        row :maquina
        row :insumo
        row :cantidad
        row :descripcion
      end
    end

  index do
    selectable_column
    column :maquina, :sortable => :maquina_id
    column :insumo, :sortable => :insumo_id
    column :cantidad
    column :descripcion
    actions
  end

  form do |f|
    f.inputs do
      f.input :maquina
      f.input :insumo
      f.input :cantidad
      f.input :descripcion
    end
    f.actions
  end
  
end
