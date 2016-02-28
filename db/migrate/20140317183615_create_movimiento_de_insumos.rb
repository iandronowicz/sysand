class CreateMovimientoDeInsumos < ActiveRecord::Migration
  def change
    create_table :movimiento_de_insumos do |t|
      t.integer :insumo_id
      t.string :tipo_de_movimiento
      t.integer :cantidad
      t.text :descripcion

      t.timestamps
    end
  end
end
