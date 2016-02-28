class CreateMaquinas < ActiveRecord::Migration
  def change
    create_table :maquinas do |t|
      t.string :marca
      t.string :modelo
      t.text :descripcion
      t.string :serie
      t.integer :horas
      t.integer :anio
      t.integer :encargado

      t.timestamps
    end
  end
end
