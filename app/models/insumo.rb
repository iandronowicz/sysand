class Insumo < ActiveRecord::Base
	include ClassyEnum::ActiveRecord
	
	belongs_to :reemplaza_insumo, :class_name => "Insumo", :foreign_key => "reemplaza_insumo_id"
	has_one :reemplazado_por, :class_name => "Insumo", :foreign_key => "reemplaza_insumo_id"
	validates :codigo, :presence => true, :uniqueness => {:case_sensitive => false}


	classy_enum_attr :tipo_de_insumo, :allow_nil => false, :allow_blank => false

	def to_s
		ret = "#{self.tipo_de_insumo.text} - #{self.codigo}"
		ret = ret + " -> REEMPLAZADO POR #{self.reemplazado_por.codigo}" unless self.reemplazado_por.nil?
		ret = ret + " -> REEMPLAZA A #{self.reemplaza_insumo.codigo}" unless self.reemplaza_insumo.nil?
		return ret
	end

	def cantidad_de_maquinas_que_lo_usan
		MaquinaUsaInsumo.where(:insumo_id => self.id).count()
	end
end
