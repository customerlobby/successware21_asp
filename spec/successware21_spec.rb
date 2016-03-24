require 'spec_helper'

RSpec.describe Successware21 do
  after do
    Successware21.reset
  end

  describe '.client' do
    it 'should be a Successware21::Client' do
      expect(Successware21.client).to be_a(Successware21::Client)
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
