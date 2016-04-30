class TipoDeTarea < ActiveRecord::Base
	validates :descripcion, :presence => true
	validates :unidad, :presence => true
	has_many :tareas

	def to_s
		"#{self.descripcion} (#{self.unidad})"
	end
end
