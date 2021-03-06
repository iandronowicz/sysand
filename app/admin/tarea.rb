ActiveAdmin.register Tarea do
	menu priority: 10
	permit_params :tipo_de_tarea_id, :descripcion, :cantidad, :precio_unitario, :precio_total
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

	config.sort_order = 'trabajos.fecha_de_inicio_desc'

	filter :trabajo
	filter :descripcion
	filter :tipo_de_tarea, as: :select, multiple: true

	show do
		attributes_table do
			row :trabajo
			row :descripcion
	    	row :tipo_de_tarea
	    	row :cantidad
	    	row("Precio unitario") { |b| number_to_currency(b.precio_unitario, unit: '$', separator: '.') }
	    	row("Precio total") { |b| number_to_currency(b.precio_total, unit: '$', separator: '.') }
	    end
  	end

	index do
	    selectable_column
	    column("Inicio", :sortable => "trabajos.fecha_de_inicio") {|t| t.trabajo.fecha_de_inicio.nil? ? "" : t.trabajo.fecha_de_inicio.strftime('%d/%m/%Y')}
	    column("Trabajo", :sortable => :trabajo_id) {|t| link_to(t.trabajo, admin_trabajo_path(t.trabajo))}
	    column :descripcion
	    column :tipo_de_tarea
	    column :cantidad
	    number_column :precio_unitario, as: :currency, unit: "$", separator: "."
	    number_column :precio_total, as: :currency, unit: "$", separator: "."
	    actions
	    div :class => "panel" do
	    	h3 "Total: #{number_to_currency(Tarea.search(params[:q]).result.sum(:precio_total), unit: '$', separator: '.')}"
	    end
  	end

  	controller do
		def scoped_collection
			super.includes(:trabajo)#.select 'id'#, count(authors.*) as author_count'
		end

		def index
			index! do |format|
		        format.xls {
		          spreadsheet = TareasSpreadsheet.new Tarea.ransack(params[:q]).result
		          send_data spreadsheet.generate_xls, filename: "#{Date.today.strftime('%d/%m/%Y')} - Tareas.xls"
		        }
		    end
		end

	end

end
