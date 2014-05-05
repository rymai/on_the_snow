require 'faraday'
require 'on_the_snow/core_ext/array'
require 'on_the_snow/core_ext/hash'

module OnTheSnow
  module Faraday
    module Response
      class OnTheSnowResponseHandler < ::Faraday::Response::Middleware

        def on_complete(env)
          env[:body] = if env[:body].has_key?('Fault')
            { 'error' => env[:body]['Fault'] }.to_result!
          else
            flatten_results = env[:body].flatten
            if flatten_results[1].empty?
              []
            else
              flatten_results[1]['return'].to_result!
            end
          end
        end
      end
    end
  end
end

Faraday.register_middleware :response, on_the_snow: OnTheSnow::Faraday::Response::OnTheSnowResponseHandler
