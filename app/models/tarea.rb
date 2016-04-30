class Tarea < ActiveRecord::Base
	belongs_to :trabajo
	belongs_to :tipo_de_tarea
end
