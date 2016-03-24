require 'spec_helper'

RSpec.describe Successware21 do
  after do
    Successware21.reset
  end

  describe ".client" do
    it "should be a Successware21::Client" do
      expect(Successware21.client).to be_a(Successware21::Client)
    end
  end

  describe '#api_key' do
    it 'should return the default api key' do
      expect(Successware21.api_key).to eq(Successware21::Configuration::DEFAULT_API_KEY)
    end
  end

  describe '#api_key=' do
    it 'should set the api key' do
      Successware21.api_key = 'test'
      expect(Successware21.api_key).to eq('test')
    end
  end

  describe '#api_version' do
    it 'should return the default api version' do
      expect(Successware21.api_version).to eq(Successware21::Configuration::DEFAULT_API_VERSION)
    end
  end

  describe '#api_version=' do
    it 'should set the api_version' do
      Successware21.api_version = '/test'
      expect(Successware21.api_version).to eq('/test')
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
