module OnTheSnow

  # Defines HTTP request methods
  #
  module Request

    # Perform an HTTP GET request
    #
    def get(*args)
      opts = args.last.is_a?(Hash) ? args.pop : {}

      request(:get, args.join('/'), opts[:params] || {}, opts[:options] || {})
    end

    private

    # Perform an HTTP request
    #
    def request(method, path, params, options)
      path = [path, api_domain, api_token].join('/') << '?' << query

      response = connection(options).run_request(method, nil, nil, nil) do |request|
        request.options[:raw] = true if options[:raw]
        case method.to_sym
        when :delete, :get
          request.url(path, params)
        when :post, :put
          request.path = path
          request.body = params unless params.empty?
        end
      end
      options[:raw] ? response : response.body
    end

    def query
      query = ['response=json']
      query << "lang=#{api_lang}" if api_lang
      query << "met=#{api_metric}" if api_metric
      query.join('&')
    end

  end

end
