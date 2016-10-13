class EstadoDeServicio < ClassyEnum::Base
end

class EstadoDeServicio::Pendiente < EstadoDeServicio
end

class EstadoDeServicio::EnProceso < EstadoDeServicio
end

class EstadoDeServicio::RealizadoInterno < EstadoDeServicio
end

class EstadoDeServicio::RealizadoExterno < EstadoDeServicio
end

class EstadoDeServicio::Facturado < EstadoDeServicio
end
