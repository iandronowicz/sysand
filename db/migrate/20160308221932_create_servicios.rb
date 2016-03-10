class CreateServicios < ActiveRecord::Migration
  def change
    create_table :servicios do |t|
      t.integer :maquina_id
      t.text :descripcion
      t.integer :maquina_horas

      t.timestamps null: false
    end
  end
end
