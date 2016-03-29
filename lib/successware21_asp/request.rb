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
        if e.message.include?('Entity with Key') && e.message.include?('does not exist')
          raise NotFoundError.new(e)
        else
          raise ParseError.new(e)
        end
      rescue Faraday::SSLError => e
        raise SSLError.new(e)
      rescue => e
        raise Error.new(e)
      end

      Response.create(response.body)
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
