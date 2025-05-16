module Weather
  module API
    class ClientBase
      include HTTParty
      include Singleton
    end
  end
end
