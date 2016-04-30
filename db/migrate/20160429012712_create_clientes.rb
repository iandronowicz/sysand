class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string :razon_social
      t.string :cuit

      t.timestamps null: false
    end
  end
end
