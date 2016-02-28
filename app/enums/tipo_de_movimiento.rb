class TipoDeMovimiento < ClassyEnum::Base
end

class TipoDeMovimiento::Entrada < TipoDeMovimiento
end

class TipoDeMovimiento::Salida < TipoDeMovimiento
end
