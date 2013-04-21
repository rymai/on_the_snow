require 'on_the_snow/config'
require 'faraday'
require 'faraday_middleware/parse_oj'
require 'on_the_snow/response/on_the_snow_response_handler'

module OnTheSnow
  module Connection

    def endpoint
      ['http:/', OnTheSnow::Config::DEFAULT_HOST, OnTheSnow::Config::DEFAULT_API_PATH].join('/')
    end

  private

    # Returns a Faraday::Connection object
    #
    # @param options [Hash] A hash of options
    # @return [Faraday::Connection]
    def connection(options = {})
      default_options = {
        headers: {
          accept: 'application/json',
          user_agent: OnTheSnow::Config::DEFAULT_USER_AGENT,
          host: OnTheSnow::Config::DEFAULT_HOST
        },
        ssl: { verify: false },
        url: endpoint,
      }

      @connection ||= Faraday.new(default_options.merge(connection_options)) do |builder|
        # builder.response :logger
        builder.response :on_the_snow
        builder.response :oj

        builder.adapter(adapter)
      end
    end
  end
end
