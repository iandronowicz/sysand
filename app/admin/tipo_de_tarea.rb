ActiveAdmin.register TipoDeTarea do
	menu priority: 11
	permit_params :descripcion, :unidad
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

	index do
	    selectable_column
	    column :descripcion
	    column :unidad
	    actions
	end

end
