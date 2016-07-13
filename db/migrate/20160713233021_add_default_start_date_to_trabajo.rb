class AddDefaultStartDateToTrabajo < ActiveRecord::Migration
  def change
  	change_column :trabajos, :fecha_de_inicio, :timestamp, :default => Time.now
  end
end
