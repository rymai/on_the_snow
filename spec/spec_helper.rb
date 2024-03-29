require 'coveralls'
Coveralls.wear!

require 'rspec'
require 'vcr'
require 'on_the_snow/core_ext/hash'
require 'on_the_snow/client'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.mock_with :rspec

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  config.before :each, :vcr do
    @client = OnTheSnow::Client.new(ForReal.credentials) if ForReal.ok?
  end
end

VCR.configure do |config|
  config.hook_into :webmock
  config.cassette_library_dir     = 'spec/fixtures/cassettes'
  config.ignore_localhost         = true
  config.default_cassette_options = { record: :new_episodes }
  config.configure_rspec_metadata!
end

module ForReal

  CREDENTIALS_FILE = '.for_real.yml'

  def self.ok?
    @available ||= File.exists?(CREDENTIALS_FILE)
  end

  def self.subscription?(subscription)
    credentials['subscription'] == subscription
  end

  def self.credentials
    yml['credentials']
  end

  def self.yml
    @yml ||= if ok?
      YAML.load(File.open(CREDENTIALS_FILE))
    end
  end

end
