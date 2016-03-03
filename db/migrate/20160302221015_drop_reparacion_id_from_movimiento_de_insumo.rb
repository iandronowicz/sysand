class DropReparacionIdFromMovimientoDeInsumo < ActiveRecord::Migration
  def change
  	remove_column :movimiento_de_insumos, :reparacion_id
  end
end
