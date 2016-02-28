class ChangePedidoPorColumn < ActiveRecord::Migration
  def change
  	rename_column :reparacions, :pedido_por, :pedido_por_id
  end
end
