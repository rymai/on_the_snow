require 'on_the_snow/response'

module OnTheSnow

  # Defines HTTP request methods
  #
  module Request

    # Perform an HTTP GET request
    #
    def get(*args)
      opts = args.last.is_a?(Hash) ? args.pop : {}

      _request(:get, args.join('/'), opts[:params] || {}, opts[:options] || {})
    end

    private

    # Perform an HTTP request
    #
    def _request(method, path, params, options)
      ::OnTheSnow::Response.new(_faraday_request(method, path, params, options), options.slice(:type))
    end

    def _faraday_request(method, path, params, options)
      path = [path, domain, token].join('/') << '?' << query(options)

      connection(options).run_request(method, nil, nil, nil) do |request|
        case method.to_sym
        when :delete, :get
          request.url(path, params)
        when :post, :put
          request.path = path
          request.body = params unless params.empty?
        end
      end
    end

    def query(options = {})
      query = ['response=json']
      query << "lang=#{lang}" if lang
      query << "met=#{metric}" if metric
      if q = options.delete(:query)
        query << q.map { |k, v| "#{k}=#{v}" }.join('&')
      end
      query.join('&')
    end

  end

end
