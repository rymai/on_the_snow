source 'https://rubygems.org'

# Specify your gem's dependencies in on_the_snow.gemspec
gemspec

gem 'rake'

# The development group will not be
# installed on Travis CI.
#
group :development do
  gem 'ruby_gntp'
  gem 'guard-rspec'
  gem 'yard'
  gem 'redcarpet'
  gem 'pimpmychangelog'
end

# The test group will be
# installed on Travis CI
#
group :test do
  gem 'rspec'
  gem 'coveralls', :require => false
end
