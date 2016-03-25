module Successware21
  module Configuration

    REQUIRED_KEYS = [
        :agent_name,
        :agent_password,
        :master_id
    ]

    VALID_OPTIONS_KEYS = [
        :connection_id,
        :company_id,
        :session_id,
        :adapter,
        :endpoint
    ] + REQUIRED_KEYS.freeze

    # Use the default Faraday adapter.
    DEFAULT_ADAPTER    = Faraday.default_adapter

    # By default use the main api URL.
    DEFAULT_ENDPOINT   = 'http://services.successware21.com:2142'.freeze

    attr_accessor *VALID_OPTIONS_KEYS

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # When this module is extended, reset all settings.
    def self.extended(base)
      base.reset
    end

    # Reset all configuration settings to default values.
    def reset

      self.endpoint = DEFAULT_ENDPOINT
      self.adapter  = DEFAULT_ADAPTER
    end
  end
end
