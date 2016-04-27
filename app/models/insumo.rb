class Insumo < ActiveRecord::Base
	include ClassyEnum::ActiveRecord
	
	belongs_to :reemplaza_insumo, :class_name => "Insumo", :foreign_key => "reemplaza_insumo_id"
	has_one :reemplazado_por, :class_name => "Insumo", :foreign_key => "reemplaza_insumo_id"
	validates :codigo, :presence => true, :uniqueness => {:case_sensitive => false}

	has_many :maquina_usa_insumos, :dependent => :destroy
	has_many :maquinas, through: :maquina_usa_insumos

	classy_enum_attr :tipo_de_insumo, :allow_nil => false, :allow_blank => false

	def to_s
		ret = "#{self.tipo_de_insumo.text} - #{self.codigo}"
		ret = ret + " -> REEMPLAZADO POR #{self.reemplazado_por.codigo}" unless self.reemplazado_por.nil?
		ret = ret + " -> REEMPLAZA A #{self.reemplaza_insumo.codigo}" unless self.reemplaza_insumo.nil?
		return ret
	end

	def maquinas_array
		return self.maquinas.to_a.map!(&:to_s)
	end

end
