module Successware21
  # Wrapper for the Successware21 REST API.
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each { |f| require f }

    include Successware21::Client::Customers
    include Successware21::Client::Transactions
    include Successware21::Client::Credentials
  end
end
