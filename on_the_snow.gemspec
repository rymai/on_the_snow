# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'on_the_snow/version'

Gem::Specification.new do |spec|
  spec.name          = 'on_the_snow'
  spec.version       = OnTheSnow::VERSION
  spec.authors       = ['Rémy Coutable']
  spec.email         = ['remy@rymai.me']
  spec.homepage      = 'https://github.com/rymai/on_the_snow'
  spec.summary       = %q{OnTheSnow Web Services REST API Ruby wrapper.}
  spec.description   = %q{OnTheSnow Web Services REST API Ruby wrapper.}
  spec.license       = 'MIT'

  spec.files        = Dir.glob('lib/**/*') + %w[CHANGELOG.md LICENSE.md README.md]
  spec.test_files   = Dir.glob('spec/**/*')
  spec.require_path = 'lib'

  spec.add_dependency 'faraday',                     '~> 0.8'
  spec.add_dependency 'faraday_middleware',          '~> 0.8'
  spec.add_dependency 'faraday_middleware-parse_oj', '~> 0.2'

  spec.add_development_dependency 'bundler', '~> 1.3'
end
