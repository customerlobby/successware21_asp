module Successware21Asp
  class Client
    module Customers

      def customers(params = {})
        data = <<-EOF
          <SessionRequest Version="string" SessionID="#{self.session_id}" RequestID="string">
            <CustomerChangeQuery Filter="string" Max="string" OrderBy="string" StyleNo="string" StyleOptions="string">
              <UTCDateTime>#{params[:date_time]}</UTCDateTime>
            </CustomerChangeQuery>
          </SessionRequest>
        EOF
        post('/', data)
      end
    end
  end
end
