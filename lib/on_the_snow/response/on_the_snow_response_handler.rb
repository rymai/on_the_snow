require 'faraday'

module OnTheSnow
  module Response
    class OnTheSnowResponseHandler < Faraday::Response::Middleware

      def on_complete(env)
        unless env[:body].has_key?('Fault')
          body = env[:body].flatten[1]['return']
          body = case body
                when Array
                  body.each { |e| e.symbolize_keys! && e = replace_booleans!(e) }
                when Hash
                  body.symbolize_keys!
                  replace_booleans!(body)
                end

          env[:body] = body
        end
      end

      private

      def replace_booleans!(body)
        body.each do |k, v|
          if v.is_a?(Hash)
            body[k] = replace_booleans!(v)
          else
            body[k] = case v
                      when 'y'
                        true
                      when 'n'
                        false
                      else
                        v
                      end
          end
        end
      end

    end
  end
end

Faraday.register_middleware :response, :on_the_snow => lambda { OnTheSnow::Response::OnTheSnowResponseHandler }
