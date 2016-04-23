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
	
	config.sort_order = 'fecha_realizado_asc'

	filter :maquina
	filter :descripcion
	filter :realizado#, as: :check_boxes
	filter :fecha_realizado

	show do
		attributes_table do
	    	row :maquina
	    	row :maquina_horas
	    	row :descripcion
	    	bool_row :realizado
	    	row :fecha_realizado
	    	list_row "Insumos", :insumos_array
	    end
  	end

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
	    #column :descripcion
	    column "Horas", :maquina_horas
	    list_column "Insumos", :insumos_array
	    column :realizado
	    column("Fecha realizado", :sortable => :fecha_realizado) {|s| s.fecha_realizado.nil? ? "" : s.fecha_realizado.strftime('%d/%m/%Y')}
	    #column :created_at
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
