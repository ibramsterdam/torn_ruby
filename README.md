# TornRuby
[![Gem Version](https://badge.fury.io/rb/torn_ruby.svg)](https://badge.fury.io/rb/torn_ruby)
An implementation of the [Torn](https://www.torn.com/api.html) V2 API using Ruby.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add torn_ruby
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install torn_ruby 
```

## Usage
To use the TornRuby gem, you’ll need a valid Torn API key.

```ruby
api_key = "Valid Torn Api Key"
client = TornRuby::Client.new(api_key:)
user = client.user
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ibramsterdam/torn_ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TornRuby project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ibramsterdam/torn_ruby/blob/main/CODE_OF_CONDUCT.md).
