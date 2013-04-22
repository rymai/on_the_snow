module OnTheSnow
  class Client

    # Wrapper for the OnTheSnow REST API regions method.
    #
    class Regions

      module Helper
        # Gets a list of Region elements which contain all the State/Provinces
        # listed by OTS. The method can be used to retrieve the list of state
        # names and state abbrev to pull down information for the region
        # specific services.
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getRegions
        #
        def regions
          @regions ||= get('regions')
        end
      end

    end

  end
end
