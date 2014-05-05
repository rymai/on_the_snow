require 'spec_helper'
require 'on_the_snow/client/region'

describe OnTheSnow::Client::Region do
  describe 'initialize' do
    context 'without a region_id' do
      let(:region) { described_class.new }

      it 'raises an ArgumentError' do
        expect { region }.to raise_error(ArgumentError)
      end
    end

    context 'with a client and a region_id' do
      let(:client) { Class.new.new }
      let(:region) { described_class.new(client, 5) }

      it 'exposes its region id' do
        region.id.should eq 5
      end
    end
  end

  let(:client) { Class.new.send(:include, described_class::Helper).new }
  let(:region) { described_class.new(client, 5) }

  describe '#states' do
    it 'calls the helper method' do
      client.should_receive(:_region_states).with(5)

      client.region(5).states
    end
  end

end

describe OnTheSnow::Client::Region::Helper do
  let(:client) { OnTheSnow::Client.new }

  it 'returns an OnTheSnow::Client::Region object' do
    region = client.region(5)
    region.should be_an(OnTheSnow::Client::Region)
    region.id.should eq 5
  end

  describe '#states' do
    it 'calls the API' do
      client.should_receive(:get).with('region/states', 5)

      client.region(5).states
    end

    context 'real request', :vcr, if: ForReal.ok? do
      it 'returns a valid response' do
        response = @client.region(5).states
        response[:states][0][:abbrev].should eq 'UK'
        response[:name].should eq 'Europe'
      end
    end
  end

end
