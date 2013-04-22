require 'faraday'
require 'on_the_snow/core_ext/array'
require 'on_the_snow/core_ext/hash'

module OnTheSnow
  module Response
    class OnTheSnowResponseHandler < Faraday::Response::Middleware

      def on_complete(env)
        unless env[:body].has_key?('Fault')
          flatten_results = env[:body].flatten
          unless flatten_results[1].empty?
            env[:body] = flatten_results[1]['return'].to_result!
          end
        end
      end

    end
  end
end

Faraday.register_middleware :response, on_the_snow: OnTheSnow::Response::OnTheSnowResponseHandler
