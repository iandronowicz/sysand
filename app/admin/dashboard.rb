ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
        column do
            panel "Trabajos sin facturar" do
                table_for Trabajo.where("estado_de_trabajo != '#{EstadoDeTrabajo::Facturado.new}' AND estado_de_trabajo != '#{EstadoDeTrabajo::Cobrado.new}'").order('fecha_de_inicio desc') do
                    column("Título")   { |trabajo| link_to(trabajo.titulo, admin_trabajo_path(trabajo)) }
                    column("Estado")   { |trabajo| status_tag trabajo.estado_de_trabajo.text }
                end
            end
            panel "Servicios pendientes" do
                table_for Servicio.where(realizado: false).order('created_at asc') do
                    column("Máquina")   { |servicio| servicio.maquina }
                    column("Descripción"){ |servicio| link_to(truncate(servicio.descripcion, :length => 140), admin_servicio_path(servicio)) }
                end
            end
            panel "Stock a reponer más urgente" do
                table_for Insumo.where("stock<maquina_usa_insumos_count AND maquina_usa_insumos_count>0 AND id NOT IN (select reemplaza_insumo_id from insumos where reemplaza_insumo_id IS NOT NULL)").order('maquina_usa_insumos_count desc').order('stock asc').limit(10) do
                    column("Insumo") { |insumo| link_to(insumo, admin_insumo_path(insumo)) }
                    column("# máquinas que lo usan") { |insumo| insumo.maquina_usa_insumos_count }
                    column("Stock") { |insumo| insumo.stock }
                end
            end
        end
        column do
            #panel "Último precio de cada tipo de tarea" do
            #    table_for Tarea.joins(:tipo_de_tarea).order('precio_unitario desc').group('tipo_de_tarea_id') do
            #        column("Tipo de tarea") { |t| t.tipo_de_tarea }
            #        column("Precio unitario") { |t| number_to_currency(t.precio_unitario, unit: '$', separator: '.') }
            #    end
            #end
            panel "Último servicio realizado a cada máquina" do
                table_for Maquina.order('modelo asc') do
                    column("Máquina") { |maquina| maquina }
                    column("Fecha") { |maquina| maquina.last_service_done.nil? ? "-" : maquina.last_service_done.fecha_realizado.strftime('%d/%m/%Y') }
                    column("Descripción"){ |maquina| maquina.last_service_done.nil? ? "-" : link_to(truncate(maquina.last_service_done.descripcion, :length => 80), admin_servicio_path(maquina.last_service_done)) }
                    column("Horas") { |maquina| maquina.last_service_done.nil? ? "-" : maquina.last_service_done.maquina_horas }
                end
            end
        end
    end
  end
end
