module FaradayMiddleware
  class Successware21AspAuth < Faraday::Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      @app.call env
    end

  end
end
