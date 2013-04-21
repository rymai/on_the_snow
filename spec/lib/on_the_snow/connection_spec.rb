require 'spec_helper'
require 'on_the_snow/connection'

describe OnTheSnow::Connection do

  let(:client) do
    stub('client', :api_domain => 'google.com',
                   :api_token => 'abcd1234',
                   :api_level => 'lite').extend(described_class)
  end

  describe '.endpoint' do
    it 'returns the default endpoint' do
      client.endpoint.should eq "http://#{OnTheSnow::Config::DEFAULT_HOST}/#{OnTheSnow::Config::DEFAULT_API_PATH}"
    end
  end

end