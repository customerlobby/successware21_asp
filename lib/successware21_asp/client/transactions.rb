module Successware21Asp
  class Client
    module Transactions

      def transactions(params = {})
        get('transactions', params)
      end

      def transaction(id, params = {})
        get("transactions/#{id}", params)
      end

    end
  end
end
