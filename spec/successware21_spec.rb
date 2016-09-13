require 'spec_helper'

RSpec.describe Successware21Asp do
  after do
    Successware21Asp.reset
  end

  before do
    @valid_params   = {
        agent_name:     'test_agent',
        user_name:      'test_user',
        user_password:  'test_user_pw',
        agent_password: 'test_agent_pw',
        master_id:      123,
        endpoint: 'www.test.com'
    }
    @invalid_params = {}
  end

  describe '.client' do
    it 'raises an exception if not given necessary params' do
      expect { Successware21Asp.client(@invalid_params) }.to raise_error('Invalid params')
    end

    it 'returns an instance of Successware21::Client if given valid params' do
      expect(Successware21Asp.client(@valid_params)).to be_a Successware21Asp::Client
    end
  end

  describe '#adapter' do
    it 'should return the default adapter' do
      expect(Successware21Asp.adapter).to eq(Successware21Asp::Configuration::DEFAULT_ADAPTER)
    end
  end

  describe '#adapter=' do
    it 'should set the adapter' do
      Successware21Asp.adapter = :typhoeus
      expect(Successware21Asp.adapter).to eq(:typhoeus)
    end
  end

  describe '#endpoint' do
    it 'should return the default endpoint' do
      expect(Successware21Asp.endpoint).to eq(Successware21Asp::Configuration::DEFAULT_ENDPOINT)
    end
  end

  describe '#endpoint=' do
    it 'should set the endpoint' do
      Successware21Asp.endpoint = 'http://www.google.com'
      expect(Successware21Asp.endpoint).to eq('http://www.google.com')
    end
  end

  describe '#configure' do
    Successware21Asp::Configuration::VALID_OPTIONS_KEYS.each do |key|

      it "should set the #{key}" do
        Successware21Asp.configure do |config|
          config.send("#{key}=", key)
          expect(Successware21Asp.send(key)).to eq(key)
        end
      end
    end
  end
end