class CreateMaquinaUsaInsumos < ActiveRecord::Migration
  def change
    create_table :maquina_usa_insumos do |t|
      t.integer :maquina_id
      t.integer :insumo_id
      t.integer :cantidad
      t.text :descripcion

      t.timestamps
    end
  end
end
