require 'spec_helper'
require 'on_the_snow/response'

describe OnTheSnow::Response do
  FaradayResponse = Struct.new(:status, :body, :response_headers) do
    def body
      env[:body]
    end

    def env
      @env ||= { body: self[:body] }
    end
  end
  let(:faraday_response_hash) { FaradayResponse.new(200, { foo: 'bar' }, []) }
  let(:faraday_response_array) { FaradayResponse.new(200, [{ foo: 'bar' }], []) }

  describe '.initialize' do
    describe 'options[:type]' do
      context ':type is :array' do
        context 'response body is a hash' do
          it 'casts body as array' do
            res = described_class.new(faraday_response_hash, type: :array)

            expect(res.body).to eq [{ foo: 'bar' }]
          end
        end

        context 'response body is an array' do
          it 'casts body as array' do
            res = described_class.new(faraday_response_array, type: :array)

            expect(res.body).to eq [{ foo: 'bar' }]
          end
        end
      end
    end
  end

end
