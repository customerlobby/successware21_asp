require 'faraday'
require 'faraday_middleware'
require 'active_support/all'
require 'successware21_asp/version'

Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each { |f| require f }
require File.expand_path('../successware21_asp/configuration', __FILE__)
require File.expand_path('../successware21_asp/api', __FILE__)
require File.expand_path('../successware21_asp/client', __FILE__)

module Successware21Asp

  extend Configuration
  # Alias for Successware21Asp::Client.new
  # @return [Successware21Asp::Client]
  def self.client(options = {})
    Successware21Asp::Client.new(options)
  end

  # Delegate to Successware21Asp::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end
end
