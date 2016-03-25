require File.expand_path('../request', __FILE__)
require File.expand_path('../response', __FILE__)
require File.expand_path('../connection', __FILE__)

module Successware21
  class API

    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    def initialize(params)
      raise 'Invalid params' unless valid_params?(params)
      options = Successware21.options.merge(params)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end      
    end

    def config
      conf = {}
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        conf[key] = send key
      end
      conf
    end

    def valid_params?(params)
      Configuration::REQUIRED_KEYS.all? { |k| params.key? k }
    end

    include Request
    include Response
    include Connection
  end
end
