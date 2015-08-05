module ZipCode
  module DB
    def country
      @country ||= ZipCode::DB.send(:registry).invert[self]
    end

    def search(key, value)
      super(key.to_sym, value)
    end

    module_function

    def for(country)
      registry[country]
    end

    def default
      @default ||= registry.values.first
    end

    def register(country, database)
      database.extend ZipCode::DB
      registry[country] = database
    end

    def registry
      @registry ||= {}
    end
    private :registry
  end
end
