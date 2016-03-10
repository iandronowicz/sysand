class AddCompletedToServicio < ActiveRecord::Migration
  def change
  	add_column :servicios, :realizado, :boolean, default: false
  	add_column :servicios, :fecha_realizado, :timestamp
  end
end
