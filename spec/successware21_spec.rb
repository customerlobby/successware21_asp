require 'spec_helper'

RSpec.describe Successware21Asp do
  after do
    Successware21Asp.reset
  end

  describe '.client' do
    it 'should be a Successware21Asp::Client' do
      expect(Successware21Asp.client).to be_a(Successware21Asp::Client)
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
