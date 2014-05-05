require 'on_the_snow/version'

module OnTheSnow

  # Defines constants and methods related to configuration
  #
  module Config

    # The HTTP connection adapter that will be used to connect if none is set
    DEFAULT_ADAPTER = :net_http

    # The Faraday connection options if none is set
    DEFAULT_CONNECTION_OPTIONS = {}

    # The default API host
    DEFAULT_HOST = 'services.onthesnow.com'

    # The beginning of the API path
    DEFAULT_API_PATH = 'axis2/services/SnowReport2009'

    # The domain for which you have access to the API
    DEFAULT_DOMAIN = nil

    # The token if none is set
    DEFAULT_TOKEN = nil

    # The language if none is set
    DEFAULT_LANG = nil

    # The metric if none is set ('imp' or 'met')
    DEFAULT_METRIC = nil

    # The subscription level access for the API
    #
    # This can be:
    #   - lite
    #   - mobile
    #   - plus (aka 'mobile plus')
    #   - web (default)
    DEFAULT_SUBSCRIPTION = 'web'

    # The value sent in the 'User-Agent' header if none is set
    DEFAULT_USER_AGENT = "OnTheSnow Ruby Gem #{OnTheSnow::VERSION}"

    # An array of valid keys in the options hash when configuring a {OnTheSnow::Client}
    VALID_OPTIONS_KEYS = [
      :adapter,
      :connection_options,
      :domain,
      :token,
      :subscription,
      :lang,
      :metric
    ]

    attr_accessor *VALID_OPTIONS_KEYS
    attr_reader :options

    # When this module is extended, set all configuration options to their default values
    #
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    #
    def configure
      yield self
      self
    end

    # Reset all configuration options to defaults
    #
    def reset
      @options = VALID_OPTIONS_KEYS.inject({}) do |opts, k|
        default_option = OnTheSnow::Config.const_get("DEFAULT_#{k.upcase}")
        self.send("#{k}=", default_option)
        opts[k.to_s] = default_option #unless default_option.nil?
        opts
      end
      self
    end

  end
end
