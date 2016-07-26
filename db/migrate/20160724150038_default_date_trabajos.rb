class DefaultDateTrabajos < ActiveRecord::Migration
  def change
  	execute "ALTER TABLE trabajos CHANGE fecha_de_inicio fecha_de_inicio TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;"
  end
end
