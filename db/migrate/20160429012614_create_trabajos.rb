class CreateTrabajos < ActiveRecord::Migration
  def change
    create_table :trabajos do |t|
      t.text :descripcion
      t.string :titulo
      t.string :estado_de_trabajo
      t.string :factura
      t.integer :cliente_id
      t.timestamp :fecha_de_inicio
      t.timestamp :fecha_de_fin

      t.timestamps null: false
    end
  end
end
