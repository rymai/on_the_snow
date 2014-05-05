require 'on_the_snow/client/abstract'

module OnTheSnow
  class Client

    # Wrapper for the OnTheSnow REST API individual state methods.
    #
    class State < Abstract

      def self.chainable_methods
        %w[cams deals news photos resorts_last_update last_resorts_updates snow_report]
      end

      module Helper
        def state(state_id)
          @states ||= {}
          @states[state_id] ||= OnTheSnow::Client::State.new(self, state_id)
        end

        private

        # Gets a list of snow cams for a state.
        #
        # @note Requires access to the OTS Cams service
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getRegionCams
        #
        def _state_cams(state_id)
          get('state/cams', state_id, options: { type: :array })
        end

        # Get a list of Deal objects which contain deals.
        #
        # @note Available to all subscribers to the service.
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getRegionDeals
        #
        def _state_deals(state_id)
          get('state/deals', state_id, options: { type: :array })
        end

        # Get a list of Story objects which contain news stories.
        #
        # @note Available to all subscribers to the service.
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getRegionNews
        #
        def _state_news(state_id)
          get('state/news', state_id, options: { type: :array })
        end

        # Gets a list of photos for a state.
        #
        # @note Requires access to the OTS Cams service
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getRegionPhotos
        #
        def _state_photos(state_id)
          get('state/photos', state_id, options: { type: :array })
        end

        # Get a list of ResortUpdateRecord objects which tells when the last
        # time a resort's info and snowreport was updated.
        #
        # @note Available to all subscribers to the service.
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getRegionResortsLastUpdated
        #
        def _state_resorts_last_update(state_id)
          get('region', state_id, 'resorts/lastupdate', options: { type: :array })
        end
        alias_method :_state_last_resorts_updates, :_state_resorts_last_update

        # Get a SnowReport for resorts in a State/Region.
        #
        # @note Details of the response depends on your subscription level.
        #
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getRegionSnowReportMobile
        # @see http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html#getRegionSnowReportMobilePlus
        #
        def _state_snow_report(state_id)
          get(subscription, 'region/resorts/snow', state_id, options: { type: :array })
        end
      end

    end

  end
end
