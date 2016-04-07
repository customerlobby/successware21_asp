module Successware21Asp
  class Client
    module Credentials

      def set_auth_params
        set_connection_id
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

        connection_data    = post('/', data)
        self.connection_id = connection_data.ConnectResponse.ConnectionID
      end

      def set_session_id
        data = <<-EOF
          <ConnectionRequest RequestID="string" ConnectionID="#{self.connection_id}" Version="string">
            <BeginSession Version="string">
              <ConnectionID>#{self.connection_id}</ConnectionID>
              <CompanyNo>#{self.company_id}</CompanyNo>
              <Username>#{self.user_name}</Username>
              <UserPassword>#{self.user_password}</UserPassword>
              <Terminal>string</Terminal>
            </BeginSession>
          </ConnectionRequest>
        EOF

        session_data    = post('/', data)
        self.session_id = session_data.BeginSessionResponse.SessionID
      end

      def end_session
        data = <<-EOF
          <SessionRequest RequestID="string" SessionID="#{self.session_id}" Version="string">
            <EndSession Version="string">
              <SessionID>#{self.session_id}</SessionID>
            </EndSession>
          </SessionRequest>
        EOF

        post('/', data)
      end

      def end_connection
        data = <<-EOF
          <ConnectionRequest RequestID="string" ConnectionID="#{self.connection_id}" Version="string">
            <Disconnect Version="string">
              <ConnectionID>#{self.connection_id}</ConnectionID>
              <Force>1</Force>
            </Disconnect>
          </ConnectionRequest>
        EOF

        post('/', data)
      end
    end
  end
end