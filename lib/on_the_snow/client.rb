require 'on_the_snow/config'
require 'on_the_snow/connection'
require 'on_the_snow/request'

require 'on_the_snow/client/attribution'
require 'on_the_snow/client/region'
require 'on_the_snow/client/regions'
require 'on_the_snow/client/resort'
require 'on_the_snow/client/resorts'
require 'on_the_snow/client/state'

module OnTheSnow

  # Wrapper for the OnTheSnow REST API
  #
  # @note All methods have been separated into modules under on_the_snow/client.
  #
  class Client
    extend Config

    include Connection
    include Request

    include Attribution::Helper
    include Region::Helper
    include Regions::Helper
    include Resort::Helper
    include Resorts::Helper
    include State::Helper

    attr_accessor *Config::VALID_OPTIONS_KEYS

    # Initializes a new API object
    #
    # @param attrs [Hash]
    # @return [OnTheSnow::Client]
    #
    def initialize(attrs = {})
      attrs = self.class.options.merge(attrs)
      Config::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", attrs[key.to_sym] || attrs[key.to_s])
      end
    end
  end

end
