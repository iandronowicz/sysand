class CreateArchivos < ActiveRecord::Migration
  def change
    create_table :archivos do |t|
      t.integer :propietario_id

      t.timestamps null: false
    end
  end
end
