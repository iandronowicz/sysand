class CreateTipoDeTareas < ActiveRecord::Migration
  def change
    create_table :tipo_de_tareas do |t|
      t.string :descripcion
      t.string :unidad

      t.timestamps null: false
    end
  end
end
