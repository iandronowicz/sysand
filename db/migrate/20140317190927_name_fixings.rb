class NameFixings < ActiveRecord::Migration
  def change
  	rename_column :insumos, :tipo, :tipo_de_insumo
  end
end
