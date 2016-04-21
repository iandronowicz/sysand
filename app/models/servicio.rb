class Servicio < ActiveRecord::Base
	belongs_to :maquina
	has_many :movimiento_de_insumos, :dependent => :destroy
	has_many :insumos, through: :movimiento_de_insumos
	validates :maquina, :presence => true
	#validates :maquina_horas, :presence => true

	after_create :update_hours
	after_update :update_hours

	validates :maquina_horas, numericality: { only_integer: true, greater_than: 0, :allow_blank => true }

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
  		ret = "#{self.maquina.to_s}"
		ret = ret + " -> HORAS: #{self.maquina_horas}" unless self.maquina_horas.nil?
		return ret
  	end
end