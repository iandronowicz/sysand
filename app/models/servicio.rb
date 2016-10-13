class Servicio < ActiveRecord::Base
	include ClassyEnum::ActiveRecord
	classy_enum_attr :estado_de_servicio, :allow_nil => false, :allow_blank => false

	after_create :update_hours
	after_update :update_hours

	belongs_to :maquina
	has_many :movimiento_de_insumos#, :dependent => :destroy
	has_many :insumos, through: :movimiento_de_insumos, :before_remove => :fire_before_remove_in_movimiento_de_insumos

	validates :maquina, :presence => true
	validates :maquina_horas, numericality: { only_integer: true, greater_than: 0, :allow_blank => true }

	has_many :archivos, class_name: "Archivo", foreign_key: "propietario_id", :dependent => :destroy
	accepts_nested_attributes_for :archivos, :reject_if => lambda { |t| t['imagen'].blank? }, :allow_destroy => true

	def update_hours
		if self.maquina_horas.nil?
			#traigo las horas de la maquina
			if not self.maquina.horas.nil?
				self.maquina_horas = self.maquina.horas
				self.save
			end
		else
			update_query = "horas = #{self.maquina_horas}"
			Maquina.where(:id => self.maquina.id).update_all(update_query)
		end
	end

	def insumos_array
		return self.insumos.to_a.map!(&:to_s)
	end

	validate do |servicio|
	    servicio.movimiento_de_insumos.each do |mdi|
	      next if mdi.valid?
	      mdi.errors.full_messages.each do |msg|
	        errors[:base] << "#{msg}"
	      end
    	end
  	end

  	def to_s
  		ret = "#{self.created_at.strftime('%d/%m/%Y')} - #{self.maquina.to_s}"
		#ret = ret + " -> HORAS: #{self.maquina_horas}" unless self.maquina_horas.nil?
		ret = ret + "#{self.realizado ? " - Realizado el #{self.fecha_realizado.strftime('%d/%m/%Y')}" : ""}"
		return ret
  	end

  	private
	  def fire_before_remove_in_movimiento_de_insumos(insumo)
	    movimiento_de_insumo = self.movimiento_de_insumos.find_by_insumo_id(insumo.id)
	    movimiento_de_insumo.destroy_stock
	  end
end