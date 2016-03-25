module Successware21
  class Client
    module Customers

      def customers(params = {})
        data = <<-EOF
          <SessionRequest Version="string" SessionID="#{self.session_id}" RequestID="string">
            <InvoiceChangeQuery Filter="string" Max="string" OrderBy="string" StyleNo="string" StyleOptions="string">
              <UTCDateTime>2010-01-01</UTCDateTime>
            </InvoiceChangeQuery>
          </SessionRequest>
        EOF
        post('/', data)
      end
    end
  end
end
