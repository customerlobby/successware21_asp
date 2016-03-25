module Successware21
  class Client
    module Credentials

      def set_auth_params
        set_connection_id
        set_company_id
        set_session_id
      end

      def set_connection_id
        data = <<-EOF
          <Connect Version="string">
            <AgentName>#{self.agent_name}</AgentName>
            <AgentPassword>#{self.agent_password}</AgentPassword>
            <MasterID>#{self.master_id}</MasterID>
            <Mode>string</Mode>
            <ServerURL>string</ServerURL>
          </Connect>
        EOF

        connection_data = post('/', data)
        self.connection_id = connection_data.ConnectResponse.ConnectionID
      end

      def set_company_id
        data = <<-EOF
          <ConnectionRequest Version="string" ConnectionID="#{self.connection_id}" RequestID="string">
            <CompanyQuery Filter="string" Max="string" OrderBy="string" StyleNo="string" StyleOptions="string"/>
          </ConnectionRequest>
        EOF

        company_data = post('/', data)
        self.company_id = company_data.CompanyQueryResponse.CompanyQueryData.CompanyQueryRecord.CompanyID
      end

      def set_session_id
        data = <<-EOF
          <ConnectionRequest RequestID="string" ConnectionID="#{self.connection_id}" Version="string">
            <BeginSession Version="string">
              <ConnectionID>#{self.connection_id}</ConnectionID>
              <CompanyNo>#{self.company_id}</CompanyNo>
              <Username>agt_clobby</Username>
              <UserPassword>clobby12.+</UserPassword>
              <Terminal>string</Terminal>
            </BeginSession>
          </ConnectionRequest>
        EOF

        session_data = post('/', data)
        self.session_id = session_data.BeginSessionResponse.SessionID
      end

    end
  end
end