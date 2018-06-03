class MovimientoDeInsumo < ActiveRecord::Base
	include ClassyEnum::ActiveRecord

	belongs_to :insumo
	belongs_to :servicio

	validates :insumo, :presence => true
	validates :cantidad, :presence => true, numericality: { only_integer: true, greater_than: 0 }

	classy_enum_attr :tipo_de_movimiento, :allow_nil => false, :allow_blank => false

	after_create :update_stock
	after_update :check_stock
	before_destroy :destroy_stock

	validate :salida_sin_stock, :if => Proc.new{|obj| obj.new_record? || obj.tipo_de_movimiento_was != obj.tipo_de_movimiento || obj.cantidad_was != obj.cantidad }

	def salida_sin_stock
		abort("Message goes here #{self.tipo_de_movimiento_was}")
	    if self.tipo_de_movimiento.salida? && self.cantidad > self.insumo.stock
	      errors.add(:cantidad, "stock disponible de  '#{self.insumo}' : #{self.insumo.stock}")
	    end
  	end

	def update_stock
		update_query = "stock = stock #{self.tipo_de_movimiento.entrada? ? "+" : "-"} #{self.cantidad}"
		Insumo.where(:id => self.insumo.id).update_all(update_query)
	end

	def check_stock
		#deshacer lo viejo
		update_query = "stock = stock #{self.tipo_de_movimiento_was.entrada? ? "-" : "+"} #{self.cantidad_was}"
		Insumo.where(:id => self.insumo_id_was).update_all(update_query)

		#aplicar lo nuevo
		update_query = "stock = stock #{self.tipo_de_movimiento.entrada? ? "+" : "-"} #{self.cantidad}"
		Insumo.where(:id => self.insumo.id).update_all(update_query)
	end

	def destroy_stock
		#y si el stock era 0 por alguna inconsistencia? que hago? impido el destroy?
		update_query = "stock = stock #{self.tipo_de_movimiento.entrada? ? "-" : "+"} #{self.cantidad}"
		Insumo.where(:id => self.insumo.id).update_all(update_query)
	end

	def to_s
		return "#{self.insumo} | #{self.tipo_de_movimiento.text}"
	end

end
