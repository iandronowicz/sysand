ActiveAdmin.register_page "Mezclador" do
	menu :priority => 12

	#menu label: "Mezclador"

	controller do

		def index
			@page_title = "Mezclador"
			render 'admin/mezclador', :layout => "active_admin"
		end

	end
end