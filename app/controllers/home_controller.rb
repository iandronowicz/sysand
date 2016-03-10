# encoding: utf-8

class HomeController < ApplicationController
  def servicio_maquina_insumos
    @insumos = Maquina.find(params[:maquina_id]).insumos
  end
end
