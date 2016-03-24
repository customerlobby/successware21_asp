module Successware21
  class Client
    module Transactions

      def transactions(params = {})
        response = get("transactions", params)
      end

      def transaction(id, params = {})
        response = get("transactions/#{id}", params)
      end

    end
  end
end
