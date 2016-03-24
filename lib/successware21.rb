require 'faraday'
require 'faraday_middleware'
require 'active_support/all'
require 'successware21/version'

Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each { |f| require f }
require File.expand_path('../successware21/configuration', __FILE__)
require File.expand_path('../successware21/api', __FILE__)
require File.expand_path('../successware21/client', __FILE__)

module Successware21

  extend Configuration
  # Alias for Successware21::Client.new
  # @return [Successware21::Client]
  def self.client(options = {})
    Successware21::Client.new(options)
  end

  # Delegate to Successware21::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end
end
