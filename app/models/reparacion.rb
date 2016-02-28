class Reparacion < ActiveRecord::Base
	belongs_to :maquina
	belongs_to :pedido_por, :class_name => "Empleado", :foreign_key => "pedido_por_id"

	def to_s
		return "#{self.created_at} - #{self.maquina}"
	end
end
