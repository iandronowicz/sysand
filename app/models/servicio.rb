class Servicio < ActiveRecord::Base
	belongs_to :maquina
	has_many :movimiento_de_insumos, :dependent => :destroy
	has_many :insumos, through: :movimiento_de_insumos
	validates :maquina, :presence => true
	validates :maquina_horas, :presence => true

	after_create :update_stock
	after_update :update_stock

	validates :maquina_horas, numericality: { only_integer: true, greater_than: 0, :allow_blank => true }

	def update_stock
		update_query = "horas = #{self.maquina_horas}"
		Maquina.where(:id => self.maquina.id).update_all(update_query) unless self.maquina_horas.nil?
	end

	def insumos_array
		return self.insumos.to_a.map!(&:to_s)
	end

end
