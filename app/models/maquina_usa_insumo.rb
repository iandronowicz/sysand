class MaquinaUsaInsumo < ActiveRecord::Base
	belongs_to :maquina
	belongs_to :insumo

	validates :maquina, :presence => true
	validates :insumo, :presence => true
	validates :cantidad, :presence => true
end
