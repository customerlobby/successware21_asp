require 'spec_helper'

RSpec.describe Successware21Asp::Client do

  it 'should connect using the configured endpoint and api version' do
    valid_params = { agent_name: 'test_agent', user_name: 'test_user', user_password: 'test_user_pw', agent_password: 'test_agent_pw', master_id: 123 }
    client     = Successware21Asp::Client.new(valid_params)
    endpoint   = URI.parse("#{client.endpoint}/")
    connection = client.send(:connection).build_url(nil).to_s
    expect(connection).to eq(endpoint.to_s)
  end

end
