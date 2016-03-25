module Successware21Asp
  class Client
    module Customers

      def customers(params = {})
        data = <<-EOF
          <Connect Version="string">
            <AgentName>clobby</AgentName>
            <AgentPassword>clobby12.+</AgentPassword>
            <MasterID>69191</MasterID>
            <Mode>string</Mode>
            <ServerURL>string</ServerURL>
          </Connect>
        EOF

        post('/', data)
      end

      def customer(id, params = {})
        get("customers/#{id}", params)
      end

    end
  end
end
