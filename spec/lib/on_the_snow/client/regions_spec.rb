require 'spec_helper'
require 'on_the_snow/client/regions'

describe OnTheSnow::Client::Regions::Helper do
  let(:client) { OnTheSnow::Client.new }

  describe '#regions' do
    it 'calls the API' do
      client.should_receive(:get).with('regions', options: { type: :array })

      client.regions
    end

    context 'real request', :vcr, if: ForReal.ok? do
      it 'returns a valid response' do
        response = @client.regions
        response[0][:id].should eq 5
        response[0][:name].should eq 'Europe'
      end
    end
  end

end
