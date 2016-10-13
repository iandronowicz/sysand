class ChangeRealizadoToEstadoServicio < ActiveRecord::Migration
  def change
  	add_column :servicios, :estado_de_servicio, :string
  	execute "update servicios set estado_de_servicio = 'pendiente';"
  end
end