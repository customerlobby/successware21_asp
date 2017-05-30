module Successware21Asp
  class Error < StandardError
    def initialize(e)
      @wrapped_exception = nil

      if e.respond_to?(:backtrace)
        super(e.message)
        @wrapped_exception = e
      else
        super(e.to_s)
      end
    end

    def backtrace
      if @wrapped_exception
        @wrapped_exception.backtrace
      else
        super
      end
    end

    def inspect
      inner = ''
      if @wrapped_exception
        inner << " wrapped=#{@wrapped_exception.inspect}"
      end
      if inner.empty?
        inner << " #{super}"
      end
      %(#<#{self.class}#{inner}>)
    end
  end

  class ConnectionError < Error; end
  class SessionRequestError < Error; end
  class BeginSessionError < Error; end
  class CustomerChangeQueryError < Error; end
  class InvoiceChangeQueryError < Error; end
  class ConnectError < Error; end
  class TimeoutError < Error; end
  class NotFoundError < Error; end
  class SSLError < Error; end
  class ParseError < Error; end

  [:Error, :ConnectionError, :TimeoutError, :NotFoundError, :SSLError, :ParseError].each do |const|
    Error.const_set(const, Successware21Asp.const_get(const))
  end
end
