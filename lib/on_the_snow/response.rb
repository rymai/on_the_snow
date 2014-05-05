module OnTheSnow

  # Defines HTTP response methods
  #
  class Response
    extend Forwardable

    def_delegators :@faraday_response, :status, :body, :response_headers

    # Perform an HTTP GET request
    #
    def initialize(faraday_response, options = {})
      @faraday_response = faraday_response

      case options[:type] || nil
      when :array
        @faraday_response.env[:body] = [@faraday_response.body] unless @faraday_response.body.is_a?(Array)
      end
    end

    def error?
      @faraday_response.body.has_key?(:error)
    end

    def method_missing(method, *args, &block)
      @faraday_response.body.send(method, *args, &block)
    end

  end

end
