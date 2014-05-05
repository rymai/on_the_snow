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
    end
  end

  let(:client) { Class.new.send(:include, described_class::Helper).new }
  let(:state) { described_class.new(client, 'CN') }

  describe '#cams' do
    it 'calls the helper method' do
      client.should_receive(:_state_cams).with('CN')

      client.state('CN').cams
    end
  end

  describe '#deals' do
    it 'calls the helper method' do
      client.should_receive(:_state_deals).with('CN')

      client.state('CN').deals
    end
  end

  describe '#news' do
    it 'calls the helper method' do
      client.should_receive(:_state_news).with('CN')

      client.state('CN').news
    end
  end

  describe '#photos' do
    it 'calls the helper method' do
      client.should_receive(:_state_photos).with('CN')

      client.state('CN').photos
    end
  end

  describe '#resorts_last_update' do
    it 'calls the helper method' do
      client.should_receive(:_state_resorts_last_update).with('CN')

      client.state('CN').resorts_last_update
    end
  end

  describe '#snow_report' do
    it 'calls the helper method' do
      client.should_receive(:_state_snow_report).with('CN')

      client.state('CN').snow_report
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

  describe '#cams' do
    it 'calls the API' do
      client.should_receive(:get).with('state/cams', 'CN', options: { type: :array })

      client.state('CN').cams
    end

    context 'real request', :vcr, if: ForReal.ok? && ForReal.subscription?('web') do
      it 'returns a valid response' do
        response = @client.state('CN').cams
        # FIME: I don't have access to the OTS Cams service
        # response[:has_nordic].should eq false
      end
    end
  end

  describe '#deals' do
    it 'calls the API' do
      client.should_receive(:get).with('state/deals', 'CN', options: { type: :array })

      client.state('CN').deals
    end

    context 'real request', :vcr, if: ForReal.ok? do
      it 'returns a valid response' do
        response = @client.state('CN').deals
        response[0][:id].should be_a(Fixnum)
        response[0][:description].should be_a(String)
      end
    end
  end

  describe '#news' do
    it 'calls the API' do
      client.should_receive(:get).with('state/news', 'CN', options: { type: :array })

      client.state('CN').news
    end

    context 'real request', :vcr, if: ForReal.ok? do
      it 'returns a valid response' do
        response = @client.state('CN').news
        response[0][:id].should be_a(Fixnum)
        response[0][:description].should be_a(String)
      end
    end
  end

  describe '#photos' do
    it 'calls the API' do
      client.should_receive(:get).with('state/photos', 'CN', options: { type: :array })

      client.state('CN').photos
    end

    context 'real request', :vcr, if: ForReal.ok? && ForReal.subscription?('web') do
      it 'returns a valid response' do
        response = @client.state('CN').photos
        # FIME: I don't have access to the OTS Cams service
        # response[:has_nordic].should eq false
      end
    end
  end

  describe '#resorts_last_update' do
    it 'calls the API' do
      client.should_receive(:get).with('region', 'CN', 'resorts/lastupdate', options: { type: :array })

      client.state('CN').resorts_last_update
    end

    context 'real request', :vcr, if: ForReal.ok? do
      it 'returns a valid response' do
        response = @client.state('CN').resorts_last_update
        response[0][:id].should eq 5
        response[0][:name].should eq 'Alpine Meadows'
      end
    end
  end

  describe '#snow_report' do
    it 'calls the API' do
      client.should_receive(:get).with('web', 'region/resorts/snow', 'CN', options: { type: :array })

      client.state('CN').snow_report
    end

    context 'real request', :vcr, if: ForReal.ok? && ForReal.subscription?('web') do
      it 'returns a valid response' do
        response = @client.state('CN').snow_report
        # FIME: I don't have access to the OTS Cams service
        # response[:has_nordic].should eq false
      end
    end
  end

end
