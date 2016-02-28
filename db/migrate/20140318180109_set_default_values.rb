class SetDefaultValues < ActiveRecord::Migration
  def change
  	change_column :insumos, :stock, :integer, default: 0
  	change_column :maquina_usa_insumos, :cantidad, :integer, default: 1
  	change_column :movimiento_de_insumos, :cantidad, :integer, default: 1
  end
end
