ActiveAdmin.register Servicio do

	permit_params :maquina_id, :maquina_horas, :descripcion, :realizado, :fecha_realizado, insumo_ids: []

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

	scope :all, :default => true

	scope :pendientes do |s|
		s.where(realizado: false)
	end

	scope :realizados do |s|
		s.where(realizado: true)
	end

	index do
	    selectable_column
	    column :maquina
	    column :descripcion
	    column :maquina_horas
	    list_column :insumos_array
	    column :realizado
	    column :fecha_realizado
	    column :created_at
	    actions
  	end

	form do |f|
		f.semantic_errors *f.object.errors.keys
    	f.inputs do
			f.input :maquina
			f.input :maquina_horas
			f.input :descripcion
	    end

	    f.inputs "Salen los siguientes insumos" do
	    	f.input :insumos, as: :check_boxes
	    end

	    f.inputs "El servicio ya fue realizado?" do
    		f.input :realizado
    		f.input :fecha_realizado, as: :date_time_picker
    	end
	    f.actions
	end
end
