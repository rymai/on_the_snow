module OnTheSnow
  class Client

    # Wrapper for the OnTheSnow REST API resorts methods.
    #
    class Resorts

      module Helper
        # Searches for resorts by distance from a provided latitude and
        # longitude. The distance is either in miles or km as determined
        # by met.
        #
        # @note Max return is 50 resorts.
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#searchResortsByGeocode
        #
        def search_resorts_by_geocode(options = {})
          mandatory_keys!(%w[lat lon], options)
          query = { distance: 50, limit: 10 }.merge(options)
          query[:get_n] = query.delete(:limit)

          @regions ||= get('find/resorts/geo', { options: { query: query } })
        end

        # Searches for resorts by name, matchining search string as %search%.
        # Orders by name.
        #
        # @note Max return is 50 resorts.
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#searchResortsByName
        #
        def search_resorts_by_name(options = {})
          mandatory_keys!(%w[search], options)
          query = { limit: 10 }.merge(options)
          query[:get_n] = query.delete(:limit)

          @regions ||= get('find/resorts/name', { options: { query: query } })
        end

        private

        def mandatory_keys!(mandatory_keys, options)
          unless (options.keys.map(&:to_s) & mandatory_keys).size == mandatory_keys.size
            raise ArgumentError, "#{mandatory_keys.join(',')} keys needed in the options hash@"
          end
        end
      end

    end

  end
end
