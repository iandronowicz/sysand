class MovimientoDeInsumo < ActiveRecord::Base
	include ClassyEnum::ActiveRecord
	
	belongs_to :insumo
	belongs_to :reparacion

	validates :insumo, :presence => true
	validates :cantidad, :presence => true

	classy_enum_attr :tipo_de_movimiento, :allow_nil => false, :allow_blank => false

	after_save :update_stock

	def update_stock
		#TODO chequear que no descontemos mas de lo que hay
		update_query = "stock = stock #{self.tipo_de_movimiento.entrada? ? "+" : "-"} #{self.cantidad}"
		Insumo.where(:id => self.insumo.id).update_all(update_query)
	end
end
