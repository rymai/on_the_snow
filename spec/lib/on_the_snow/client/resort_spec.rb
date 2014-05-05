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
    end
  end

  let(:client) { Class.new.send(:include, described_class::Helper).new }
  let(:resort) { described_class.new(client, 5) }

  describe '#attribution' do
    it 'calls the helper method' do
      client.should_receive(:_resort_attribution).with(5)

      client.resort(5).attribution
    end
  end

  describe '#cams' do
    it 'calls the helper method' do
      client.should_receive(:_resort_cams).with(5)

      client.resort(5).cams
    end
  end

  describe '#deals' do
    it 'calls the helper method' do
      client.should_receive(:_resort_deals).with(5)

      client.resort(5).deals
    end
  end

  describe '#info' do
    it 'calls the helper method' do
      client.should_receive(:_resort_info).with(5)

      client.resort(5).info
    end
  end

  describe '#news' do
    it 'calls the helper method' do
      client.should_receive(:_resort_news).with(5)

      client.resort(5).news
    end
  end

  describe '#photos' do
    it 'calls the helper method' do
      client.should_receive(:_resort_photos).with(5)

      client.resort(5).photos
    end
  end

  describe '#snow_report' do
    it 'calls the helper method' do
      client.should_receive(:_resort_snow_report).with(5)

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

  describe '#attribution' do
    it 'calls the API' do
      client.should_receive(:get).with('resort/attribution', 5)

      client.resort(5).attribution
    end

    context 'real request', :vcr, if: ForReal.ok? do
      it 'returns a valid response' do
        response = @client.resort(5).attribution
        response[:resort_id].should eq 5
        response[:credit_line].should eq 'Snow Reports provided by OnTheSnow.com'
      end
    end
  end

  describe '#cams' do
    it 'calls the API' do
      client.should_receive(:get).with('resort/cams', 5, options: { type: :array })

      client.resort(5).cams
    end

    context 'real request', :vcr, if: ForReal.ok? && ForReal.subscription?('web') do
      it 'returns a valid response' do
        response = @client.resort(5).cams
        # FIME: I don't have access to the OTS Cams service
        # response[:has_skiing].should eq true
      end
    end
  end

  describe '#deals' do
    it 'calls the API' do
      client.should_receive(:get).with('resort/deal', 5, options: { type: :array })

      client.resort(5).deals
    end

    context 'real request', :vcr, if: ForReal.ok? do
      it 'returns a valid response' do
        response = @client.resort(5).deals
        response[0][:id].should be_a(Fixnum)
        response[0][:description].should be_a(String)
      end
    end
  end

  describe '#info' do
    it 'calls the API' do
      client.should_receive(:get).with('web', 'resort/info', 5)

      client.resort(5).info
    end

    context 'real request', :vcr, if: ForReal.ok? do
      it 'returns a valid response' do
        response = @client.resort(5).info
        response[:latitude].should eq 39.1663235
        response[:elevation_base].should eq 2083
      end
    end
  end

  describe '#news' do
    it 'calls the API' do
      client.should_receive(:get).with('resort/news', 5, options: { type: :array })

      client.resort(5).news
    end

    context 'real request', :vcr, if: ForReal.ok? do
      it 'returns a valid response' do
        response = @client.resort(5).news
        response[0][:id].should be_a(Fixnum)
        response[0][:description].should be_a(String)
      end
    end
  end

  describe '#photos' do
    it 'calls the API' do
      client.should_receive(:get).with('resort/photos', 5, options: { type: :array })

      client.resort(5).photos
    end

    context 'real request', :vcr, if: ForReal.ok? && ForReal.subscription?('web') do
      it 'returns a valid response' do
        response = @client.resort(5).photos
        # FIME: I don't have access to the OTS Cams service
        # response[0][:id].should eq 584821
      end
    end
  end

  describe '#snow_report' do
    it 'calls the API' do
      client.should_receive(:get).with('web', 'resort/snow', 5)

      client.resort(5).snow_report
    end

    context 'real request', :vcr, if: ForReal.ok? do
      it 'returns a valid response' do
        response = @client.resort(5).snow_report
        response[:has_skiing].should eq true
        response[:has_nordic].should eq false
      end
    end
  end

end
