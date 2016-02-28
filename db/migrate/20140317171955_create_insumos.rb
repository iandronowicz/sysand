class CreateInsumos < ActiveRecord::Migration
  def change
    create_table :insumos do |t|
      t.string :tipo
      t.text :descripcion
      t.integer :stock
      t.integer :reemplaza_insumo

      t.timestamps
    end
  end
end
