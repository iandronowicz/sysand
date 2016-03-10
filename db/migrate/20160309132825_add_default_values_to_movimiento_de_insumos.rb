class AddDefaultValuesToMovimientoDeInsumos < ActiveRecord::Migration
  def change
  	change_column :movimiento_de_insumos, :tipo_de_movimiento, :string, :default => TipoDeMovimiento::Salida.new.to_s
  end
end