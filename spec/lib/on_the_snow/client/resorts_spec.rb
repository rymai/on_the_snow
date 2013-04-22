require 'spec_helper'
require 'on_the_snow/client/regions'

describe OnTheSnow::Client::Resorts::Helper do
  let(:client) { OnTheSnow::Client.new }

  describe '#search_resorts_by_geocode' do
    context 'without the required arguments' do
      it 'raises an ArgumentError' do
        expect { client.search_resorts_by_geocode }.to raise_error(ArgumentError)
      end
    end

    context 'with the required arguments' do
      it 'calls the API' do
        client.should_receive(:get).with('find/resorts/geo', { options: { query: { lat: 38, lon: -121, distance: 50, get_n: 10 } } })

        client.search_resorts_by_geocode(lat: 38, lon: -121)
      end
    end

    context 'real request', :vcr, if: ForReal.ok? do
      it 'returns a valid response' do
        response = @client.search_resorts_by_geocode(lat: 38, lon: -121, distance: 200)
        response[0][:id].should eq 134
        response[0][:distance].should eq 94
      end
    end
  end

  describe '#search_resorts_by_name' do
    context 'without the required arguments' do
      it 'raises an ArgumentError' do
        expect { client.search_resorts_by_name }.to raise_error(ArgumentError)
      end
    end

    context 'with the required arguments' do
      it 'calls the API' do
        client.should_receive(:get).with('find/resorts/name', { options: { query: { search: 'mammoth', get_n: 10 } } })

        client.search_resorts_by_name(search: 'mammoth')
      end
    end

    context 'real request', :vcr, if: ForReal.ok? do
      it 'returns a valid response' do
        response = @client.search_resorts_by_name(search: 'mammoth')
        # FIME: It returns nothing...?
        # response[0][:id].should eq 134
        # response[0][:distance].should eq 94
      end
    end
  end

end
