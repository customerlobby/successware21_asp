module Successware21Asp
  module Response
    def self.create(response_hash)
      data = response_hash.dup rescue response_hash
      data.extend(self)
      data
    end

    attr_reader :pagination
    attr_reader :meta
  end
end
