module Successware21Asp
  class Client
    module Companies

      def companies()
        data = <<-EOF
        <ConnectionRequest RequestID="string" ConnectionID="#{self.connection_id}" Version="string"> 
          <CompanyQuery StyleOptions="string" StyleNo="string" OrderBy="string" Max="string" Filter="string"/>
        </ConnectionRequest>
        EOF

        data = post('/', data)
        return data unless data.present? && data.CompanyQueryResponse
        data.CompanyQueryResponse.CompanyQueryData.CompanyQueryRecord
      end
    end
  end
end
