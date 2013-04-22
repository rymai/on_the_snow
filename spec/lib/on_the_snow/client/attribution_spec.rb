require 'spec_helper'
require 'on_the_snow/client/attribution'

describe OnTheSnow::Client::Attribution::Helper do
  let(:client) { OnTheSnow::Client.new }

  describe '#attribution' do
    it 'calls the API' do
      client.should_receive(:get).with('attribution')

      client.attribution
    end

    context 'real request', :vcr, if: ForReal.ok? do
      it 'returns a valid response' do
        response = @client.attribution
        response[:credit_line].should eq 'Snow Reports provided by OnTheSnow.com'
      end
    end
  end

end
