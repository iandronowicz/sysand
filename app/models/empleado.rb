class Empleado < ActiveRecord::Base
	validates :nombre, :presence => true
	validates :apellido, :presence => true
	validates :dni, :presence => true, :length => { :is => 8 }
	validates :cuil, :presence => true, :length => { :is => 13 }, :format => { :with => /[0-9]{2}-[0-9]{8}-[0-9]{1}/ }

	def to_s
		"#{self.nombre} #{self.apellido}"
	end
end
