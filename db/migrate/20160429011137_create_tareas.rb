class CreateTareas < ActiveRecord::Migration
  def change
    create_table :tareas do |t|
      t.string :descripcion
      t.float :cantidad
      t.float :precio_unitario
      t.float :precio_total
      t.integer :tipo_de_tarea_id

      t.timestamps null: false
    end
  end
end
