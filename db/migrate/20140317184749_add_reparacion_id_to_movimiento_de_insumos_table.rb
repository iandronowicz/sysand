class AddReparacionIdToMovimientoDeInsumosTable < ActiveRecord::Migration
  def change
  	add_column :movimiento_de_insumos, :reparacion_id, :integer
  end
end
