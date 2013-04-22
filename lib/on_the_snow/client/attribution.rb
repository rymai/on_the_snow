module OnTheSnow
  class Client

    # Wrapper for the OnTheSnow REST API atribution method.
    #
    class Attribution

      module Helper
        # Gets the credit line data for the SnowReport service.
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getSiteAttribution
        #
        def attribution
          @attribution ||= get('attribution')
        end
      end

    end

  end
end
