ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
        column do
            panel "Servicios pendientes" do
                table_for Servicio.where(realizado: false).order('created_at desc').limit(10) do
                    column("Máquina")   { |servicio| servicio.maquina }
                    column("Descripción"){ |servicio| truncate(servicio.descripcion, :length => 80) }
                    column("Ver")   { |servicio| link_to("Ver", admin_servicio_path(servicio)) }
                end
            end
            panel "Stock a reponer más urgente" do
                table_for Insumo.where("stock<maquina_usa_insumos_count AND maquina_usa_insumos_count>0 AND id NOT IN (select reemplaza_insumo_id from insumos where reemplaza_insumo_id IS NOT NULL)").order('stock asc').order('maquina_usa_insumos_count desc').limit(10) do
                    column("Insumo") { |insumo| insumo }
                    column("# máquinas que lo usan") { |insumo| insumo.maquina_usa_insumos_count }
                    column("Stock") { |insumo| insumo.stock }
                end
            end
        end
        column do
            panel "Últimos servicios realizados a cada máquina" do
                table_for Maquina.order('modelo asc') do
                    column("Máquina") { |maquina| maquina }
                    column("Fecha") { |maquina| maquina.last_service_done.nil? ? "-" : maquina.last_service_done.fecha_realizado.strftime('%d/%m/%Y') }
                    column("Descripción") { |maquina| maquina.last_service_done.nil? ? "-" : truncate(maquina.last_service_done.descripcion, :length => 80) }
                    column("Ver") { |maquina| maquina.last_service_done.nil? ? "-" : link_to("Ver", admin_servicio_path(maquina.last_service_done)) }
                end
            end
        end
    end
  end
end
