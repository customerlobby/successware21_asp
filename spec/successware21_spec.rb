require 'spec_helper'

RSpec.describe Successware21 do
  after do
    Successware21.reset
  end

  before do
    @valid_params = { agent_name: 'test_agent', user_name: 'test_user', user_password: 'test_user_pw', agent_password: 'test_agent_pw', master_id: 123 }
    @invalid_params = {}
  end

  describe '.client' do
    it 'raises an exception if not given necessary params' do      
      expect{ Successware21.client(@invalid_params) }.to raise_error("Invalid params")
    end

    it 'returns an instance of Successware21::Client if given valid params' do
      expect(Successware21.client(@valid_params)).to be_a Successware21::Client
    end
  end

  describe '#adapter' do
    it 'should return the default adapter' do
      expect(Successware21.adapter).to eq(Successware21::Configuration::DEFAULT_ADAPTER)
    end
  end

  describe '#adapter=' do
    it 'should set the adapter' do
      Successware21.adapter = :typhoeus
      expect(Successware21.adapter).to eq(:typhoeus)
    end
  end

  describe '#endpoint' do
    it 'should return the default endpoint' do
      expect(Successware21.endpoint).to eq(Successware21::Configuration::DEFAULT_ENDPOINT)
    end
  end

  describe '#endpoint=' do
    it 'should set the endpoint' do
      Successware21.endpoint = 'http://www.google.com'
      expect(Successware21.endpoint).to eq('http://www.google.com')
    end
  end

  describe '#configure' do
    Successware21::Configuration::VALID_OPTIONS_KEYS.each do |key|

      it "should set the #{key}" do
        Successware21.configure do |config|
          config.send("#{key}=", key)
          expect(Successware21.send(key)).to eq(key)
        end
      end
    end
  end
end