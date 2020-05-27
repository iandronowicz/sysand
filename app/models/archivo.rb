class Archivo < ActiveRecord::Base
	has_one_attached :imagen#, :styles => { :small => "150x150>", :large => "960x720>" }
	#validates_attachment_presence :imagen
	#validates_attachment_size :imagen, :less_than => 5.megabytes
	#validates_attachment_content_type :imagen, content_type: /\Aimage\/.*\Z/
end
