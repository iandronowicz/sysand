ActiveAdmin.register Insumo do
  permit_params :tipo_de_insumo, :codigo, :descripcion, :stock, :reemplaza_insumo_id
  
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

  config.sort_order = 'maquina_usa_insumos_count_desc'

  filter :maquina
  filter :codigo
  filter :tipo_de_insumo, as: :select, collection: TipoDeInsumo.select_options

  show do
    attributes_table do
        row("Tipo de insumo") { |b| status_tag b.tipo_de_insumo }
        row :codigo
        row :stock
        row :descripcion
        row("# maquinas que lo usan") { |b| b.maquina_usa_insumos_count }
      end
    end

  scope :all, :default => true

  scope :sin_stock do |insumos|
    insumos.where(stock: 0)
  end

  scope :con_stock do |insumos|
     insumos.where("stock > ?", 0)
  end

  scope :usados_en_maquinas do |insumos|
     insumos.where("maquina_usa_insumos_count > ?", 0)
  end

  index do
    selectable_column
    column("Tipo", :sortable => :tipo_de_insumo) {|insumo| status_tag insumo.tipo_de_insumo.text}
    column :codigo
    column :stock
    #column :descripcion
    column "# maquinas que lo usan", :maquina_usa_insumos_count
    actions
  end

  form do |f|
    f.inputs do
      f.input :tipo_de_insumo, :as => :select, :collection => TipoDeInsumo.select_options, :include_blank => false
      f.input :codigo
      f.input :descripcion
      f.input :stock
      if f.object.new_record?
        f.input :reemplaza_insumo
      else
        f.input :reemplaza_insumo, :as => :select, :collection => Insumo.where("id != #{f.object.id}").collect { |v| [v, v.id] }, :include_blank => true
      end
    end
    f.actions
  end
  
end
