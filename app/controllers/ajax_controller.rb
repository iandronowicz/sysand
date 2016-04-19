# encoding: utf-8

class AjaxController < ApplicationController
  def insumos_de_maquina
  	if admin_user_signed_in?
		insumos_jsoned = Maquina.find(params[:maquina_id]).insumos.map do |i|
  			{ :id => i.id, :to_s => i.to_s, :stock => i.stock }
		end
    	render :json => insumos_jsoned
	end
  end
end
