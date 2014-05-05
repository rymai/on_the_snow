require 'on_the_snow/client/abstract'

module OnTheSnow
  class Client

    # Wrapper for the OnTheSnow REST API individual resort methods.
    #
    class Resort < Abstract

      def self.chainable_methods
        %w[attribution cams deals info news photos snow_report]
      end

      module Helper
        def resort(resort_id)
          _resorts[resort_id] ||= OnTheSnow::Client::Resort.new(self, resort_id)
        end

        private

        def _resorts
          @_resorts ||= {}
        end

        # Gets the credit line data for resortd in SnowReport service.
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getResortAttribution
        #
        def _resort_attribution(resort_id)
          get('resort/attribution', resort_id)
        end

        # Gets a list of snow cams for a given resort.
        #
        # @note Requires access to the OTS Cams service.
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getResortCams
        #
        def _resort_cams(resort_id)
          get('resort/cams', resort_id, options: { type: :array })
        end

        # Get a list of Deal objects which contain deals.
        #
        # @note Available to all subscribers to the service.
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getResortDeals
        #
        def _resort_deals(resort_id)
          get('resort/deal', resort_id, options: { type: :array })
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
        def _resort_info(resort_id)
          get(subscription, 'resort/info', resort_id)
        end

        # Get a list of Story objects which contain news stories.
        #
        # @note Available to all subscribers to the service.
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getResortNews
        #
        def _resort_news(resort_id)
          get('resort/news', resort_id, options: { type: :array })
        end

        # Gets a list of resort provided photos for a given resort.
        #
        # @note Requires access to the OTS Cams service.
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getResortPhotos
        #
        def _resort_photos(resort_id)
          get('resort/photos', resort_id, options: { type: :array })
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
        def _resort_snow_report(resort_id)
          get(subscription, 'resort/snow', resort_id)
        end
      end

    end

  end
end
