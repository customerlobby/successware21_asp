require 'faraday_middleware'
Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each { |f| require f }

module Successware21Asp
  module Connection
    private

    def connection
      options = {
          :url => "#{endpoint}/"
      }

      Faraday::Connection.new(options) do |connection|
        connection.use FaradayMiddleware::Successware21AspAuth
        connection.use FaradayMiddleware::Mashify
        connection.response :xml
        connection.adapter(adapter)
        connection.response :logger
      end
    end
  end
end
