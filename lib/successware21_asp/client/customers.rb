module Successware21Asp
  class Client
    module Customers

      def customers(params = { page_size: 100, page_no: 1 })
        data = <<-EOF
          <SessionRequest Version="string" SessionID="#{self.session_id}" RequestID="string">
            <CustomerChangeQuery Filter="string" Max="string" OrderBy="string" StyleNo="string" StyleOptions="string" PageSize="#{params[:page_size]}" PageNo="#{params[:page_no]}">
              <ChangedSince>#{params[:date_time]}</ChangedSince>
            </CustomerChangeQuery>
          </SessionRequest>
        EOF

        data = post('/', data)
        return data unless data.present? && data.CustomerChangeQueryResponse
        data.CustomerChangeQueryResponse.CustomerChangeQueryData.CustomerChangeQueryRecord
      end
    end
  end
end
