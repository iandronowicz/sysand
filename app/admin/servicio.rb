ActiveAdmin.register Servicio do

	permit_params :estado_de_servicio, :maquina_id, :maquina_horas, :descripcion, :fecha_realizado, insumo_ids: [], archivos_attributes: [:id, :propietario_id, :imagen, :_destroy]
menu priority: 7
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
	
	config.sort_order = 'fecha_realizado_desc'

	filter :maquina
	filter :descripcion
	filter :estado_de_servicio, as: :select, collection: EstadoDeServicio.select_options, multiple: true
	filter :fecha_realizado

	show do
		attributes_table do
	    	row :maquina
	    	row :maquina_horas
	    	row :descripcion
	    	row("Estado") { |b| status_tag b.estado_de_servicio }
	    	row :fecha_realizado
	    	list_row "Insumos", :insumos_array
	    end
	    panel "Archivos" do
		    table_for servicio.archivos do
	        	image_column :imagen, style: :large
		    end
  		end unless servicio.archivos.count == 0
  	end

	scope :all

	scope :pendientes, :default => true do |s|
		s.where(estado_de_servicio: EstadoDeServicio::Pendiente.new.to_s)
	end

	scope :realizados do |s|
		s.where("estado_de_servicio IN (?)", [EstadoDeServicio::RealizadoInterno.new.to_s, EstadoDeServicio::RealizadoExterno.new.to_s])
	end

	scope :no_facturados do |s|
		s.where(estado_de_servicio: EstadoDeServicio::RealizadoExterno.new.to_s)
	end

	index do
	    selectable_column
	    column :maquina
	    #column :descripcion
	    column "Horas", :maquina_horas
	    list_column "Insumos", :insumos_array
	    column("Estado") { |b| status_tag b.estado_de_servicio }
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
	    	f.input :estado_de_servicio, :as => :select, :collection => EstadoDeServicio.select_options, :include_blank => false
    		f.input :fecha_realizado, as: :date_time_picker
    	end

    	f.inputs "Archivos" do
    		f.has_many :archivos, allow_destroy: true do |ff|
	          ff.input :imagen, :as => :file, :hint => (ff.template.image_tag(ff.object.imagen.url(:small)) unless ff.object.new_record?)
	        end
    	end

	    f.actions
	end
end
