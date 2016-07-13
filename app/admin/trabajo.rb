ActiveAdmin.register Trabajo do
	menu priority: 9
	permit_params :factura, :cliente_id, :titulo, :descripcion, :estado_de_trabajo, :fecha_de_inicio, :fecha_de_fin, tareas_attributes: [:id, :tipo_de_tarea_id, :descripcion, :cantidad, :precio_unitario, :precio_total, :_destroy]
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
	config.sort_order = 'fecha_de_inicio_desc'

	scope :all

	scope :no_facturados, :default => true do |t|
		t.where("estado_de_trabajo <> ?", EstadoDeTrabajo::Facturado.new.to_s)
	end

	filter :cliente
	filter :titulo
	filter :descripcion
	filter :estado_de_trabajo, as: :select, collection: EstadoDeTrabajo.select_options, multiple: true
	filter :factura
	filter :fecha_de_inicio

	show do
		attributes_table do
			row :cliente
	    	row :titulo
	    	row :descripcion
	    	row("Estado") { |b| status_tag b.estado_de_trabajo }
	    	row :fecha_de_inicio
	    	row :fecha_de_fin
	    	#list_row "Tareas", :tareas_array
	    	row("Total") { |b| number_to_currency(b.total, unit: '$', separator: '.') }
	    	row :factura
	    end
	    panel "Tareas" do
		    table_for trabajo.tareas do
	        	#column("Inicio") {:fecha_de_inicio.nil? ? "" : t.trabajo.fecha_de_inicio.strftime('%d/%m/%Y')}
			    column :descripcion
			    column :tipo_de_tarea
			    column :cantidad
			    number_column :precio_unitario, as: :currency, unit: "$", separator: "."
			    number_column :precio_total, as: :currency, unit: "$", separator: "."
		    end
  		end unless trabajo.tareas.count == 0
  	end
	
	index do
	    selectable_column
	    column("Inicio", :sortable => :fecha_de_inicio) {|t| t.fecha_de_inicio.nil? ? "" : t.fecha_de_inicio.strftime('%d/%m/%Y')}
	    column("Título", :sortable => :titulo) {|t| link_to(t.titulo, admin_trabajo_path(t))}
	    column :descripcion
	    column("Estado", :sortable => :estado_de_trabajo) {|t| status_tag t.estado_de_trabajo.text}
	    number_column :total, as: :currency, unit: "$", separator: "."
	    #actions

	    div :class => "panel" do
	    	h3 "Total: #{number_to_currency(Trabajo.joins(:tareas).search(params[:q]).result.sum(:precio_total), unit: '$', separator: '.')}"
	    end
  	end

	form do |f|
		f.semantic_errors *f.object.errors.keys
    	f.inputs do
    		f.input :cliente
			f.input :titulo
			f.input :descripcion
			f.input :estado_de_trabajo, :as => :select, :collection => EstadoDeTrabajo.select_options, :include_blank => false
			f.input :fecha_de_inicio, as: :date_time_picker
			f.input :fecha_de_fin, as: :date_time_picker
			f.input :factura
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

	controller do
		def index
			index! do |format|
		        format.xls {
		          spreadsheet = TrabajosSpreadsheet.new @trabajos
		          send_data spreadsheet.generate_xls, filename: "#{Date.today.strftime('%d/%m/%Y')} - Trabajos.xls"
		        }
		    end
		end
	end

end
