class TipoDeTarea < ActiveRecord::Base
	validates :descripcion, :presence => true
	validates :unidad, :presence => true
	has_many :tareas

	def to_s
		s = "#{self.descripcion} (#{self.unidad})"
	end

	def ultima_tarea
		return Tarea.where("tipo_de_tarea_id = ?", self.id).order("created_at DESC").limit(1).first
	end

	def to_s_plus
		s = self.to_s
		ut = self.ultima_tarea
		s += " | #{ActionController::Base.helpers.number_to_currency(ut.precio_unitario, unit: '$', separator: '.')} | #{ut.created_at.strftime('%d/%m/%Y')}" unless ut.nil?
		return s
	end
end
