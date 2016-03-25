require 'spec_helper'

RSpec.describe Successware21Asp::Client do

  it 'should connect using the configured endpoint and api version' do
    client = Successware21Asp::Client.new
    endpoint = URI.parse("#{client.endpoint}#{client.api_version}/")
    connection = client.send(:connection).build_url(nil).to_s
    expect(connection).to eq(endpoint.to_s)
  end

end
