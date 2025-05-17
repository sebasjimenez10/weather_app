module Weather
  module API
    # ClientBase is the base class for all API clients.
    class ClientBase
      include HTTParty

      # Defines the base abstract method for forecast implementations.
      def forecast(query)
        raise NotImplementedError, "Subclasses must implement the forecast method"
      end
    end
  end
end
