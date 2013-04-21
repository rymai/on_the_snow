require 'spec_helper'
require 'on_the_snow/client'

describe OnTheSnow::Client do

  describe 'initialize' do
    context 'without any attrs set' do
      let(:client) { described_class.new }

      OnTheSnow::Config::VALID_OPTIONS_KEYS.each do |valid_option_key|
        describe ".#{valid_option_key}" do
          it "returns the default #{valid_option_key}" do
            client.send(valid_option_key).should eq OnTheSnow::Config.const_get("DEFAULT_#{valid_option_key.upcase}")
          end
        end

        describe ".#{valid_option_key}=" do
          it "sets the #{valid_option_key}" do
            client.send("#{valid_option_key}=", 'foo')
            client.send(valid_option_key).should eq 'foo'
          end
        end
      end
    end

    context 'with attrs set' do
      let(:client) { described_class.new(subscription: 'lite') }

      it 'returns the custom subscription' do
        client.subscription.should eq 'lite'
      end
    end
  end

end
