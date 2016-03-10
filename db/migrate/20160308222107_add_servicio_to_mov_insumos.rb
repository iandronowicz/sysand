class AddServicioToMovInsumos < ActiveRecord::Migration
  def change
  	add_column :movimiento_de_insumos, :servicio_id, :integer
  end
end
