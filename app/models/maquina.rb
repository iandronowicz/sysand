class Maquina < ActiveRecord::Base
	include ClassyEnum::ActiveRecord
	
	belongs_to :encargado, :class_name => "Empleado", :foreign_key => "encargado_id"
	validates :modelo, :presence => true

	classy_enum_attr :marca, :allow_nil => false, :allow_blank => false

	has_many :maquina_usa_insumos, :dependent => :destroy
	has_many :insumos, through: :maquina_usa_insumos

	def to_s
		"#{self.marca.text} #{self.modelo} #{(self.anio ? self.anio : "")} #{self.encargado}"
	end
end