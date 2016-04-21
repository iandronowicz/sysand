class Maquina < ActiveRecord::Base
	include ClassyEnum::ActiveRecord
	
	belongs_to :encargado, :class_name => "Empleado", :foreign_key => "encargado_id"
	validates :modelo, :presence => true

	classy_enum_attr :marca, :allow_nil => false, :allow_blank => false

	has_many :maquina_usa_insumos, :dependent => :destroy
	has_many :insumos, through: :maquina_usa_insumos
	has_many :servicios

	def to_s
		"#{self.marca.text} #{self.modelo} #{(self.anio ? self.anio : "")}"# #{self.encargado}"
	end

	def last_service_done
  		Servicio.where({realizado: true, maquina_id: self.id}).order('fecha_realizado desc').limit(1).first
  	end
end