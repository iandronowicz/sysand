class MaquinaUsaInsumo < ActiveRecord::Base
	belongs_to :maquina
	belongs_to :insumo, counter_cache: true

	validates :maquina, :presence => true
	validates :insumo, :presence => true
	validates :cantidad, :presence => true

	validates :maquina_id, uniqueness: {scope: :insumo_id, :message => " esta máquina ya usa este insumo"}

	def to_s
		return "#{self.maquina} <-> #{self.insumo.codigo}"
	end
end
