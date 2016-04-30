class ChangeTypeTareas < ActiveRecord::Migration
  def change
  	change_column :tareas, :precio_unitario, :decimal, :precision => 11, :scale => 2
  	change_column :tareas, :precio_total, :decimal, :precision => 11, :scale => 2
  end
end
