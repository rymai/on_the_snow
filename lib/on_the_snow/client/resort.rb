# require 'on_the_snow/client/helpers'

module OnTheSnow
  class Client

    # Wrapper for the OnTheSnow REST API individual resort methods
    #
    class Resort

      module Helper
        def resort(resort_id)
          OnTheSnow::Client::Resort.new(self, resort_id)
        end

        # Gets the credit line data for resortd in SnowReport service.
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getResortAttribution
        #
        def resort_attribution(resort_id)
          get('resort/attribution', resort_id)
        end

        # Gets a list of snow cams for a given resort.
        #
        # @note Requires access to the OTS Cams service.
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getResortCams
        #
        def resort_cams(resort_id)
          get('resort/cams', resort_id)
        end

        # Get a list of Deal objects which contain deals.
        #
        # @note Available to all subscribers to the service.
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getResortDeals
        #
        def resort_deals(resort_id)
          get('resort/deal', resort_id)
        end

        # Gets a view of the resorts information.
        #
        # Note: Details of the response depends on your subscription level.
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getResortInfoLite
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getResortInfoMobile
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getResortInfoMobilePlus
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getResortInfoWeb
        #
        def resort_info(resort_id)
          get(subscription, 'resort/info', resort_id)
        end

        # Get a list of Story objects which contain news stories.
        #
        # @note Available to all subscribers to the service.
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getResortNews
        #
        def resort_news(resort_id)
          get('resort/news', resort_id)
        end

        # Gets a list of resort provided photos for a given resort.
        #
        # @note Requires access to the OTS Cams service.
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getResortPhotos
        #
        def resort_photos(resort_id)
          get('resort/photos', resort_id)
        end

        # Get a snow report for a resort.
        #
        # @note Details of the response depends on your subscription level.
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getResortSnowReportLite
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getResortSnowReportMobile
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getResortSnowReportMobilePlus
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getResortSnowReportWeb
        #
        def resort_snow_report(resort_id)
          get(subscription, 'resort/snow', resort_id)
        end
      end

      attr_reader :client, :id

      def initialize(client, resort_id)
        @client = client
        @id = resort_id
      end

      %w[attribution cams deals info news photos snow_report].each do |method_name|
        define_method(method_name) do
          client.send("resort_#{method_name}", id)
        end
      end

    end

  end
end
