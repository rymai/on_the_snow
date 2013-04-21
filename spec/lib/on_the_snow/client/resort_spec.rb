require 'spec_helper'
require 'on_the_snow/client/resort'

describe OnTheSnow::Client::Resort do
  describe 'initialize' do
    context 'without a resort_id' do
      let(:resort) { described_class.new }

      it 'raises an ArgumentError' do
        expect { resort }.to raise_error(ArgumentError)
      end
    end

    context 'with a client and a resort_id' do
      let(:client) { Class.new.new }
      let(:resort) { described_class.new(client, 5) }

      it 'exposes its resort id' do
        resort.id.should eq 5
      end

      it 'exposes its client' do
        resort.client.should eq client
      end
    end
  end

  let(:client) { Class.new.send(:include, OnTheSnow::Client::Resort::Helper).new }
  let(:resort) { described_class.new(client, 5) }

  describe '#attribution' do
    it 'calls the helper method' do
      client.should_receive(:resort_attribution).with(5)

      client.resort(5).attribution
    end
  end

  describe '#cams' do
    it 'calls the helper method' do
      client.should_receive(:resort_cams).with(5)

      client.resort(5).cams
    end
  end

  describe '#deals' do
    it 'calls the helper method' do
      client.should_receive(:resort_deals).with(5)

      client.resort(5).deals
    end
  end

  describe '#info' do
    it 'calls the helper method' do
      client.should_receive(:resort_info).with(5)

      client.resort(5).info
    end
  end

  describe '#news' do
    it 'calls the helper method' do
      client.should_receive(:resort_news).with(5)

      client.resort(5).news
    end
  end

  describe '#photos' do
    it 'calls the helper method' do
      client.should_receive(:resort_photos).with(5)

      client.resort(5).photos
    end
  end

  describe '#snow_report' do
    it 'calls the helper method' do
      client.should_receive(:resort_snow_report).with(5)

      client.resort(5).snow_report
    end
  end

end

describe OnTheSnow::Client::Resort::Helper do
  let(:client) { OnTheSnow::Client.new }

  it 'returns an OnTheSnow::Client::Resort object' do
    resort = client.resort(5)
    resort.should be_an(OnTheSnow::Client::Resort)
    resort.id.should eq 5
  end

  describe '#resort_attribution' do
    it 'calls the API' do
      client.should_receive(:get).with('resort/attribution', 5)

      client.resort_attribution(5)
    end

    context 'real request', :vcr, :if => ForReal.ok? do
      it 'returns a valid response' do
        response = @client.resort_attribution(5)
        response[:credit_line].should eq 'Snow Reports provided by OnTheSnow.com'
      end

      it 'returns a valid response' do
        response = @client.resort(5).attribution
        response[:resort_id].should eq 5
      end
    end
  end

  describe '#resort_cams' do
    it 'calls the API' do
      client.should_receive(:get).with('resort/cams', 5)

      client.resort_cams(5)
    end

    context 'real request', :vcr, :if => ForReal.ok? && ForReal.subscription?('web') do
      it 'returns a valid response' do
        response = @client.resort_cams(5)
        # FIME: I don't have access to the OTS Cams service
        # response[:has_nordic].should eq false
      end

      it 'returns a valid response' do
        response = @client.resort(5).cams
        # FIME: I don't have access to the OTS Cams service
        # response[:has_skiing].should eq true
      end
    end
  end

  describe '#resort_deals' do
    it 'calls the API' do
      client.should_receive(:get).with('resort/deal', 5)

      client.resort_deals(5)
    end

    context 'real request', :vcr, :if => ForReal.ok? do
      it 'returns a valid response' do
        response = @client.resort_deals(5)
        response[0][:description].should eq 'Squaw Valley and Alpine Meadows are offering several ways to hit the slopes for cheap.'
      end

      it 'returns a valid response' do
        response = @client.resort(5).deals
        response[0][:id].should eq 584698
      end
    end
  end

  describe '#resort_info' do
    it 'calls the API' do
      client.should_receive(:get).with('web', 'resort/info', 5)

      client.resort_info(5)
    end

    context 'real request', :vcr, :if => ForReal.ok? do
      it 'returns a valid response' do
        response = @client.resort_info(5)
        response[:elevation_base].should eq 2083
      end

      it 'returns a valid response' do
        response = @client.resort(5).info
        response[:latitude].should eq 39.1663235
      end
    end
  end

  describe '#resort_news' do
    it 'calls the API' do
      client.should_receive(:get).with('resort/news', 5)

      client.resort_news(5)
    end

    context 'real request', :vcr, :if => ForReal.ok? do
      it 'returns a valid response' do
        response = @client.resort_news(5)
        response[0][:description].should eq 'Winter had one last gasp but spring will now settle in for the West Coast mountains.'
      end

      it 'returns a valid response' do
        response = @client.resort(5).news
        response[0][:id].should eq 584821
      end
    end
  end

  describe '#resort_photos' do
    it 'calls the API' do
      client.should_receive(:get).with('resort/photos', 5)

      client.resort_photos(5)
    end

    context 'real request', :vcr, :if => ForReal.ok? && ForReal.subscription?('web') do
      it 'returns a valid response' do
        response = @client.resort_photos(5)
        # FIME: I don't have access to the OTS Cams service
        # response[0][:description].should eq '...'
      end

      it 'returns a valid response' do
        response = @client.resort(5).photos
        # FIME: I don't have access to the OTS Cams service
        # response[0][:id].should eq 584821
      end
    end
  end

  describe '#resort_snow_report' do
    it 'calls the API' do
      client.should_receive(:get).with('web', 'resort/snow', 5)

      client.resort_snow_report(5)
    end

    context 'real request', :vcr, :if => ForReal.ok? do
      it 'returns a valid response' do
        response = @client.resort_snow_report(5)
        response[:has_nordic].should eq false
      end

      it 'returns a valid response' do
        response = @client.resort(5).snow_report
        response[:has_skiing].should eq true
      end
    end
  end

end
