module Successware21Asp
  # Defines HTTP request methods
  module Request
    # Perform an HTTP GET request
    def get(path, options = {})
      request(:get, path, options)
    end

    # Perform an HTTP POST request
    def post(path, options = {})
      request(:post, path, options)
    end

    private

    # Perform an HTTP request
    def request(method, path, options)
      begin
        response = connection.send(method) do |request|
          case method
            when :get
              formatted_options = format_options(options)
              request.url(path, formatted_options)
            when :post, :put
              request.body = options unless options.empty?
              request.url(path)
            else
              return
          end
          request.options.timeout      = 5 # open / read timeout is five seconds.
          request.options.open_timeout = 2 # connection open timeout is two seconds.
        end
      rescue Faraday::ConnectionFailed => e
        raise ConnectionError.new(e)
      rescue Faraday::TimeoutError => e
        raise TimeoutError.new(e)
      rescue Faraday::ResourceNotFound => e
        raise NotFoundError.new(e)
      rescue Faraday::ParsingError => e
        raise ParseError.new(e)
      rescue Faraday::SSLError => e
        raise SSLError.new(e)
      rescue => e
        raise Error.new(e)
      end

      resp = handle_response(response)
      raise ConnectionError.new(resp) unless resp == 'valid'

      Response.create(response.body)
    end

    def handle_response(response)
      return response.body.SessionRequestResponse.ResultText if invalid_session_request?(response)
      return response.body.BeginSessionResponse.ResultText if invalid_begin_session_request?(response)
      return response.body.ConnectResponse.ResultText if invalid_connection_request?(response)
      'valid'
    end

    def invalid_session_request?(response)
      response.body.SessionRequestResponse && response.body.SessionRequestResponse.Successful == 'false'
    end

    def invalid_begin_session_request?(response)
      response.body.BeginSessionResponse && response.body.BeginSessionResponse.Successful == 'false'
    end

    def invalid_connection_request?(response)
      response.body.ConnectResponse && response.body.ConnectResponse.Successful == 'false'
    end

    # Format the Options before you send them off to Successware21Asp
    def format_options(options)
      return if options.blank?
      options[:fields]    = format_fields(options[:fields]) if options.has_key?(:fields)
      options[:limit]     = options[:limit] if options.has_key?(:limit)
      options[:pageindex] = options[:page] if options.has_key?(:page)
      options
    end

    # Format the fields to a format that the Successware21Asp likes
    # @param [Array or String] fields can be specified as an Array or String
    # @return String
    def format_fields(fields)
      if fields.instance_of?(Array)
        fields.join(',')
      elsif fields.instance_of?(String)
        return fields
      end
    end

  end
end
