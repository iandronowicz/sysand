class AddCodigoToInsumo < ActiveRecord::Migration
  def change
  	add_column :insumos, :codigo, :string
  end
end
