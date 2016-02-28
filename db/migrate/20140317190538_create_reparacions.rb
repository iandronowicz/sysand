class CreateReparacions < ActiveRecord::Migration
  def change
    create_table :reparacions do |t|
      t.integer :maquina_id
      t.text :descripcion
      t.datetime :fecha_pedido
      t.datetime :fecha_a_realizar
      t.datetime :fecha_realizado
      t.integer :pedido_por

      t.timestamps
    end
  end
end
