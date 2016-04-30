class EstadoDeTrabajo < ClassyEnum::Base
end

class EstadoDeTrabajo::Pendiente < EstadoDeTrabajo
end

class EstadoDeTrabajo::EnProceso < EstadoDeTrabajo
end

class EstadoDeTrabajo::Finalizado < EstadoDeTrabajo
end

class EstadoDeTrabajo::Facturado < EstadoDeTrabajo
end

class EstadoDeTrabajo::Cobrado < EstadoDeTrabajo
end
