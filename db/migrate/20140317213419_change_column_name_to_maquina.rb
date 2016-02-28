class ChangeColumnNameToMaquina < ActiveRecord::Migration
  def change
  	rename_column :maquinas, :encargado, :encargado_id
  end
end
