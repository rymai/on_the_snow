# On The Snow API Wrapper
[![Gem Version](https://badge.fury.io/rb/on_the_snow.png)](http://badge.fury.io/rb/on_the_snow) [![Build Status](https://secure.travis-ci.org/rymai/on_the_snow.png?branch=master)](http://travis-ci.org/rymai/on_the_snow) [![Dependency Status](https://gemnasium.com/rymai/on_the_snow.png)](https://gemnasium.com/rymai/on_the_snow) [![Code Climate](https://codeclimate.com/github/rymai/on_the_snow.png)](https://codeclimate.com/github/rymai/on_the_snow) [![Coverage Status](https://coveralls.io/repos/rymai/on_the_snow/badge.png?branch=master)](https://coveralls.io/r/rymai/on_the_snow)

This is an [OnTheSnow Web Services REST API](http://www.onthesnow.com/ots/webservice_tools/OTSWebService2009.html) Ruby wrapper that aims to support all the API methods.

* Tested against Ruby 1.9.2, 1.9.3, Rubinius (1.9) & JRuby (1.9).
* Not compatible with Ruby 1.8!

## Installation

Add this line to your application's `Gemfile`:

```bash
gem 'on_the_snow'
```

And then execute:

```bash
$ bundle
```

## Usage

```ruby
on_the_snow = OnTheSnow::Client.new(domain: 'google.com',
                                    token: 'abcd1234',
                                    subscription: 'lite',
                                    lang: 'en',
                                    metric: 'met')

on_the_snow.resort(5).attribution
=> { credit_line: 'Snow Reports provided by OnTheSnow.com', ... }

# you can also use the shortcut method:
on_the_snow = OnTheSnow.new(...)
```

### `OnTheSnow::Client#initialize` options

```ruby
:domain        # Your subscription domain, mandatory.
:token         # Your subscritpion token, mandatory. You can find your token by visiting http://services.onthesnow.com/axis2/services/SnowReport2009/tokens/YOUREMAIL/YOURPASSWORD
:subscription  # Represents your level of subscription. It can be set to 'lite', 'mobile', 'plus' (aka Mobile plus) and 'web', defaults to 'web'.
:lang          # Language for the results.
:metric        # Metric system for the results. It can be set to 'imp' (imperial) and 'met' (metric).
               # Note: You must include both language and metric in your query string to override the default language.
```

## Public API

### `OnTheSnow`

Method:

* `.new(options = {})` : this is an alias for `OnTheSnow::Client.new`

### `OnTheSnow::Client`

Methods:

* `.new(options = {})`
* `#resort(resort_id)` : returns a new `OnTheSnow::Client::Resort`

### `OnTheSnow::Client::Attribution`

Provides the `#attribution` method to any instance of `OnTheSnow::Client`.

Example:
```ruby
on_the_snow = OnTheSnow::Client.new
on_the_snow.attribution
=> { credit_line: 'Snow Reports provided by OnTheSnow.com' }
```

### `OnTheSnow::Client::Region`

Provides the `#region` method to any instance of `OnTheSnow::Client`.

Method:

* `#states`

Example:
```ruby
on_the_snow = OnTheSnow::Client.new
on_the_snow.region(5).states
=> [{ id: 5, name: 'Europe', ... }]
```

### `OnTheSnow::Client::Regions`

Provides the `#regions` method to any instance of `OnTheSnow::Client`.

Example:
```ruby
on_the_snow = OnTheSnow::Client.new
on_the_snow.regions
=> [{ id: 5, name: 'Europe', states: [{ id: 73, abbrev: 'UK' }, ...] }]
```

### `OnTheSnow::Client::Resort`

Provides the `#resort` method to any instance of `OnTheSnow::Client`.

Methods:

* `#attribution`
* `#cams`
* `#deals`
* `#info`
* `#news`
* `#photos`
* `#snow_report`

Example:
```ruby
on_the_snow = OnTheSnow::Client.new
on_the_snow.resort(5).attribution
=> { credit_line: 'Snow Reports provided by OnTheSnow.com', ... }
```

### `OnTheSnow::Client::Resorts`

Provides the following methods to any instance of `OnTheSnow::Client`:

* `#search_resorts_by_geocode`
* `#search_resorts_by_name`

Example:
```ruby
on_the_snow = OnTheSnow::Client.new
on_the_snow.search_resorts_by_geocode(lat: 38, lon: -121, distance: 200)
=> [{ id: 42, distance: 94, ... }]

on_the_snow = OnTheSnow::Client.new
on_the_snow.search_resorts_by_name(search: 'mammoth')
=> [{ id: 42, ... }]
```

### `OnTheSnow::Client::State`

Provides the `#state` method to any instance of `OnTheSnow::Client`.

Methods:

* `#cams`
* `#deals`
* `#news`
* `#photos`
* `#resorts_last_update`
* `#snow_report`

Example:
```ruby
on_the_snow = OnTheSnow::Client.new
on_the_snow.state('CN').news
=> [{ id: 42, description: 'News content.', ... }]
```

Please consult the [RubyDoc](http://rubydoc.info/gems/on_the_snow/frames) for more details.

## File an issue

Before you file an issue, make sure you have read the *[Contributing guide](https://github.com/rymai/on_the_snow/blob/master/CONTRIBUTING.md)* that contains some important information.

You can report bugs and feature requests to [GitHub Issues](https://github.com/rymai/on_the_snow/issues).

## Development

* Documentation hosted at [RubyDoc](http://rubydoc.info/gems/on_the_snow/frames).
* Source hosted at [GitHub](https://github.com/rymai/on_the_snow).

Pull requests are very welcome! Please try to follow these simple rules if applicable:

* Please create a topic branch for every separate change you make.
* Make sure your patches are well tested. All specs must pass on [Travis CI](https://travis-ci.org/rymai/on_the_snow).
* Update the [Yard](http://yardoc.org/) documentation.
* Update the [README](https://github.com/rymai/on_the_snow/blob/master/README.md).
* Update the [CHANGELOG](https://github.com/rymai/on_the_snow/blob/master/CHANGELOG.md) for noteworthy changes (don't forget to run `bundle exec pimpmychangelog` and watch the magic happen)!
* Please **do not change** the version number.

## Author

[Rémy Coutable](https://github.com/rymai) ([@rymai](http://twitter.com/rymai), [rymai.me](http://rymai.me))

## Contributors

https://github.com/rymai/on_the_snow/contributors
