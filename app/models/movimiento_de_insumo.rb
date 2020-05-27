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

	validate :salida_sin_stock, :if => Proc.new{|obj| obj.insumo.presence && obj.tipo_de_movimiento.salida? && ( ( !obj.new_record? && obj.cantidad_was != obj.cantidad ) || obj.new_record? ) }

	def salida_sin_stock
		stock_nuevo_requerido = self.cantidad - (self.new_record? ? 0 : self.cantidad_was)
		#abort("Message goes here #{stock_nuevo_requerido}")
    if stock_nuevo_requerido > self.insumo.stock
      errors.add(:cantidad, "no hay stock nuevo solicitado de '#{self.insumo}', solo quedan : #{self.insumo.stock}")
    end
	end

	def update_stock
		update_query = "stock = stock #{self.tipo_de_movimiento.entrada? ? "+" : "-"} #{self.cantidad}"
		Insumo.where(:id => self.insumo.id).update_all(update_query)
	end

	def check_stock
		#deshacer lo viejo
		#abort("CANTIDAD_before_last_save=#{self.cantidad_before_last_save}")
		update_query = "stock = stock #{self.tipo_de_movimiento_before_last_save == TipoDeMovimiento::Entrada.new.to_s ? "-" : "+"} #{self.cantidad_before_last_save}"
		Insumo.where(:id => self.insumo_id_before_last_save).update_all(update_query)

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
