require 'spec_helper'
require 'on_the_snow/client/state'

describe OnTheSnow::Client::State do
  describe 'initialize' do
    context 'without a state_id' do
      let(:state) { described_class.new }

      it 'raises an ArgumentError' do
        expect { state }.to raise_error(ArgumentError)
      end
    end

    context 'with a client and a state_id' do
      let(:client) { Class.new.new }
      let(:state) { described_class.new(client, 'CN') }

      it 'exposes its state id' do
        state.id.should eq 'CN'
      end

      it 'exposes its client' do
        state.client.should eq client
      end
    end
  end

  let(:client) { Class.new.send(:include, described_class::Helper).new }
  let(:state) { described_class.new(client, 'CN') }

  describe '#cams' do
    it 'calls the helper method' do
      client.should_receive(:state_cams).with('CN')

      client.state('CN').cams
    end
  end

  describe '#deals' do
    it 'calls the helper method' do
      client.should_receive(:state_deals).with('CN')

      client.state('CN').deals
    end
  end

end

describe OnTheSnow::Client::State::Helper do
  let(:client) { OnTheSnow::Client.new }

  it 'returns an OnTheSnow::Client::State object' do
    state = client.state('CN')
    state.should be_an(OnTheSnow::Client::State)
    state.id.should eq 'CN'
  end

  describe '#state_cams' do
    it 'calls the API' do
      client.should_receive(:get).with('state/cams', 'CN')

      client.state_cams('CN')
    end

    context 'real request', :vcr, if: ForReal.ok? && ForReal.subscription?('web') do
      it 'returns a valid response' do
        response = @client.state_cams('CN')
        # FIME: I don't have access to the OTS Cams service
        # response[:has_nordic].should eq false
      end

      it 'returns a valid response' do
        response = @client.state('CN').cams
        # FIME: I don't have access to the OTS Cams service
        # response[:has_nordic].should eq false
      end
    end
  end

  describe '#state_deals' do
    it 'calls the API' do
      client.should_receive(:get).with('state/deals', 'CN')

      client.state_deals('CN')
    end

    context 'real request', :vcr, if: ForReal.ok? do
      it 'returns a valid response' do
        response = @client.state_deals('CN')
        response[0][:description].should eq 'A list of the early bird season pass prices for ski resorts in California.'
      end

      it 'returns a valid response' do
        response = @client.state('CN').deals
        response[0][:id].should eq 584723
      end
    end
  end

  describe '#state_news' do
    it 'calls the API' do
      client.should_receive(:get).with('state/news', 'CN')

      client.state_news('CN')
    end

    context 'real request', :vcr, if: ForReal.ok? do
      it 'returns a valid response' do
        response = @client.state_news('CN')
        response[0][:description].should eq 'Winter had one last gasp but spring will now settle in for the West Coast mountains.'
      end

      it 'returns a valid response' do
        response = @client.state('CN').news
        response[0][:id].should eq 584821
      end
    end
  end

  describe '#state_photos' do
    it 'calls the API' do
      client.should_receive(:get).with('state/photos', 'CN')

      client.state_photos('CN')
    end

    context 'real request', :vcr, if: ForReal.ok? && ForReal.subscription?('web') do
      it 'returns a valid response' do
        response = @client.state_photos('CN')
        # FIME: I don't have access to the OTS Cams service
        # response[:has_nordic].should eq false
      end

      it 'returns a valid response' do
        response = @client.state('CN').photos
        # FIME: I don't have access to the OTS Cams service
        # response[:has_nordic].should eq false
      end
    end
  end

  describe '#state_resorts_last_update' do
    it 'calls the API' do
      client.should_receive(:get).with('region', 'CN', 'resorts/lastupdate')

      client.state_resorts_last_update('CN')
    end

    context 'real request', :vcr, if: ForReal.ok? do
      it 'returns a valid response' do
        response = @client.state_resorts_last_update('CN')
        response[0][:name].should eq 'Alpine Meadows'
      end

      it 'returns a valid response' do
        response = @client.state('CN').resorts_last_update
        response[0][:id].should eq 5
      end
    end
  end

  describe '#state_snow_report' do
    it 'calls the API' do
      client.should_receive(:get).with('web', 'region/resorts/snow', 'CN')

      client.state_snow_report('CN')
    end

    context 'real request', :vcr, if: ForReal.ok? && ForReal.subscription?('web') do
      it 'returns a valid response' do
        response = @client.state_snow_report('CN')
        # FIME: I don't have access to the OTS Cams service
        # response[:has_nordic].should eq false
      end

      it 'returns a valid response' do
        response = @client.state('CN').snow_report
        # FIME: I don't have access to the OTS Cams service
        # response[:has_nordic].should eq false
      end
    end
  end

end
