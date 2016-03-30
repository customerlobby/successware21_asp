module Successware21Asp
  # Wrapper for the Successware21 REST API.
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each { |f| require f }

    include Successware21Asp::Client::Customers
    include Successware21Asp::Client::Transactions
    include Successware21Asp::Client::Credentials
  end
end
