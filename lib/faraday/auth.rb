module FaradayMiddleware
  # TODO: This class may or may not be needed. It depends on how the target API handles authentication.
  # TODO: If you remove this class remember to also remove it from the Connection Faraday configuration.
  class Successware21AspAuth < Faraday::Middleware

    # TODO: Pass in whatever tokens, keys needed to connect to the target API. These should be available
    # TODO: from the Configuration class.
    def initialize(app, api_key)
      @app          = app
      @api_key      = api_key
    end

    def call(env)
      # env[:request_headers] = env[:request_headers].merge('Authorization' => "Basic #{@api_key}")
      @app.call env
    end

  end
end
