require 'on_the_snow/config'
require 'on_the_snow/connection'
require 'on_the_snow/request'
require 'on_the_snow/client/resort'

module OnTheSnow

  # Wrapper for the OnTheSnow REST API
  #
  # @note All methods have been separated into modules under on_the_snow/client.
  #
  class Client
    extend Config

    include Connection
    include Request

    include Resort::Helper

    attr_accessor *Config::VALID_OPTIONS_KEYS

    # Initializes a new API object
    #
    # @param attrs [Hash]
    # @return [OnTheSnow::Client]
    #
    def initialize(attrs = {})
      attrs = self.class.options.merge(attrs)
      Config::VALID_OPTIONS_KEYS.each do |key|
        instance_variable_set("@#{key}", attrs[key])
      end
    end
  end

end
