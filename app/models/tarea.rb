class Tarea < ActiveRecord::Base
	belongs_to :trabajo
	belongs_to :tipo_de_tarea

	def to_s
		"#{self.descripcion} | #{self.tipo_de_tarea} | #{self.cantidad} | #{ActionController::Base.helpers.number_to_currency(self.precio_unitario, unit: '$', separator: '.')} | #{ActionController::Base.helpers.number_to_currency(self.precio_total, unit: '$', separator: '.')}"
	end
end
