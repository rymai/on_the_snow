require 'on_the_snow/client/abstract'

module OnTheSnow
  class Client

    # Wrapper for the OnTheSnow REST API individual state methods.
    #
    class State < Abstract

      def self.chainable_methods
        %w[cams deals news photos resorts_last_update snow_report]
      end

      module Helper
        def state(state_id)
          @states ||= {}
          @states[state_id] ||= OnTheSnow::Client::State.new(self, state_id)
        end

        # Gets a list of snow cams for a state.
        #
        # @note Requires access to the OTS Cams service
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getRegionCams
        #
        def state_cams(state_id)
          get('state/cams', state_id)
        end

        # Get a list of Deal objects which contain deals.
        #
        # @note Available to all subscribers to the service.
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getRegionDeals
        #
        def state_deals(state_id)
          get('state/deals', state_id)
        end

        # Get a list of Story objects which contain news stories.
        #
        # @note Available to all subscribers to the service.
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getRegionNews
        #
        def state_news(state_id)
          get('state/news', state_id)
        end

        # Gets a list of photos for a state.
        #
        # @note Requires access to the OTS Cams service
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getRegionPhotos
        #
        def state_photos(state_id)
          get('state/photos', state_id)
        end

        # Get a list of ResortUpdateRecord objects which tells when the last time a resort's info and snowreport was updated.
        #
        # @note Requires access to the OTS Cams service
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getRegionResortsLastUpdated
        #
        def state_resorts_last_update(state_id)
          get('region', state_id, 'resorts/lastupdate')
        end

        # Get a SnowReport for resorts in a State/Region.
        #
        # @note Details of the response depends on your subscription level.
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getRegionSnowReportMobile
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getRegionSnowReportMobilePlus
        #
        def state_snow_report(state_id)
          get(subscription, 'region/resorts/snow', state_id)
        end
      end

    end

  end
end
