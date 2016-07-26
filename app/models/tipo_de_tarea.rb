class TipoDeTarea < ActiveRecord::Base
	validates :descripcion, :presence => true
	validates :unidad, :presence => true
	has_many :tareas

	def to_s
		s = "#{self.descripcion} (#{self.unidad})"
	end

	def to_s_plus
		s = self.to_s
		latest_price = Tarea.where("tipo_de_tarea_id = ?", self.id).order("created_at DESC").limit(1).first
		s += " | #{ActionController::Base.helpers.number_to_currency(latest_price.precio_unitario, unit: '$', separator: '.')} | #{latest_price.created_at.strftime('%d/%m/%Y')}" unless latest_price.nil?
		return s
	end
end
