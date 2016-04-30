class AddTrabajoToTarea < ActiveRecord::Migration
  def change
  	add_column :tareas, :trabajo_id, :integer
  end
end
