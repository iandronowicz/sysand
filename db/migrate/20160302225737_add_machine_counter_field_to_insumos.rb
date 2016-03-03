class AddMachineCounterFieldToInsumos < ActiveRecord::Migration
  def self.up
    add_column :insumos, :maquina_usa_insumos_count, :integer, :null => false, :default => 0
    Insumo.reset_column_information
    Insumo.find_each do |b|
      Insumo.reset_counters b.id, :maquinas
    end
  end
end
