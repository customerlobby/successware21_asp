require 'faraday_middleware'
Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each{|f| require f}

module Successware21
  module Connection
    private

    def connection
      options = {
        :url => "#{endpoint}/"
      }
      
      # TODO: Remove or update the Successware21Auth middleware as needed. See the faraday/auth.rb
      Faraday::Connection.new(options) do |connection|
        connection.use FaradayMiddleware::Successware21Auth, api_key
        connection.use FaradayMiddleware::Mashify
        connection.response :xml
        connection.adapter(adapter)
        connection.response :logger
      end
    end
  end
end
