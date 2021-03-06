ActiveAdmin.register Empleado do
  permit_params :nombre, :apellido, :dni, :cuil

  menu priority: 2
  
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
    column :nombre
    column :apellido
    column :dni
    column :cuil
    actions
  end
  
end
