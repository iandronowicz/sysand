class Trabajo < ActiveRecord::Base
	include ClassyEnum::ActiveRecord
	classy_enum_attr :estado_de_trabajo, :allow_nil => false, :allow_blank => false
	validates :titulo, :presence => true
	validates :cliente, :presence => true

	has_many :tareas, :dependent => :destroy
	accepts_nested_attributes_for :tareas, allow_destroy: true

	belongs_to :cliente

	def total
		total = 0
		self.tareas.each do |tarea|
			total = total + tarea.precio_total
		end
		total
	end

	def tareas_array
		return self.tareas.to_a.map!(&:to_s)
	end

	def to_s
		self.titulo
	end
end
