class ChangeColumnNameToInsumo < ActiveRecord::Migration
  def change
  	rename_column :insumos, :reemplaza_insumo, :reemplaza_insumo_id
  end
end
