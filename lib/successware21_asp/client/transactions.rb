module Successware21Asp
  class Client
    module Transactions

      def transactions(params = {})
        data = <<-EOF
          <SessionRequest Version="string" SessionID="#{self.session_id}" RequestID="string">
            <InvoiceChangeQuery Filter="string" Max="string" OrderBy="string" StyleNo="string" StyleOptions="string">
              <UTCDateTime>#{params[:date_time]}</UTCDateTime>
            </InvoiceChangeQuery>
          </SessionRequest>
        EOF
        post('/', data)
      end
    end
  end
end
