require 'on_the_snow/client/abstract'

module OnTheSnow
  class Client

    # Wrapper for the OnTheSnow REST API individual region methods.
    #
    class Region < Abstract

      def self.chainable_methods
        %w[states]
      end

      module Helper
        def region(region_id)
          _regions[region_id] ||= OnTheSnow::Client::Region.new(self, region_id)
        end

        private


        def _regions
          @_regions ||= {}
        end

        # Gets a Region object which contain all the State/Provinces listed by
        # OTS for that region. The method can be used to retrieve the list of
        # state names and state abbrev to pull down information for the region
        # specific services.
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getRegion
        #
        def _region_states(region_id)
          get('region/states', region_id)
        end
      end

    end

  end
end
