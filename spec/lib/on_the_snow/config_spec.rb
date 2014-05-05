require 'spec_helper'
require 'on_the_snow/config'

describe OnTheSnow::Config do
  let(:configurable) { Class.new.extend(described_class) }

  described_class::VALID_OPTIONS_KEYS.each do |valid_option_key|
    describe "options[]" do
      it "returns the default #{valid_option_key}" do
        configurable.options[valid_option_key.to_s].should eq described_class.const_get("DEFAULT_#{valid_option_key.upcase}")
      end
    end

    describe ".#{valid_option_key}" do
      it "returns the default #{valid_option_key}" do
        configurable.send(valid_option_key).should eq described_class.const_get("DEFAULT_#{valid_option_key.upcase}")
      end
    end

    describe ".#{valid_option_key}=" do
      it "sets the #{valid_option_key}" do
        configurable.send("#{valid_option_key}=", 'foo')
        configurable.send(valid_option_key).should eq 'foo'
      end
    end
  end

  describe '.configure' do
    described_class::VALID_OPTIONS_KEYS.each do |key|
      it "sets the #{key}" do
        configurable.configure do |config|
          config.send("#{key}=", key)
          configurable.send(key).should eq key
        end
      end
    end
  end

end
