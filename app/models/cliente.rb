class Cliente < ActiveRecord::Base
	validates :razon_social, :presence => true
	validates_format_of :cuit, with: /\A\d{2}\-\d{8}\-\d{1}\z/

	def to_s
		self.razon_social
	end
end
