ActiveAdmin.register Trabajo do
	permit_params :titulo, :descripcion, :estado_de_trabajo, :fecha_de_inicio, :fecha_de_fin, tareas_attributes: [:id, :tipo_de_tarea_id, :descripcion, :cantidad, :precio_unitario, :precio_total, :_destroy]
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
	    column :titulo
	    column :descripcion
	    column("Estado", :sortable => :estado_de_trabajo) {|t| status_tag t.estado_de_trabajo.text}
	    number_column :total, as: :currency, unit: "$", separator: "."
	    actions

	    div :class => "panel" do
	    	h3 "Total: #{number_to_currency(Trabajo.joins(:tareas).search(params[:q]).result.sum(:precio_total), unit: '$', separator: '.')}"
	    end
  	end

	form do |f|
		f.semantic_errors *f.object.errors.keys
    	f.inputs do
			f.input :titulo
			f.input :descripcion
			f.input :estado_de_trabajo, :as => :select, :collection => EstadoDeTrabajo.select_options, :include_blank => false
			f.input :fecha_de_inicio, as: :date_time_picker
			f.input :fecha_de_fin, as: :date_time_picker
	    end
	    f.inputs "Tareas realizadas" do
	        f.has_many :tareas, allow_destroy: true do |ff|
	          ff.input :tipo_de_tarea
	          ff.input :descripcion
	          ff.input :cantidad
	          ff.input :precio_unitario
	          ff.input :precio_total
	        end
      	end
	    f.actions
	end

end
