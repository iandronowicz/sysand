class CreateEmpleados < ActiveRecord::Migration
  def change
    create_table :empleados do |t|
      t.string :nombre
      t.string :apellido
      t.string :dni
      t.string :cuil

      t.timestamps
    end
  end
end
