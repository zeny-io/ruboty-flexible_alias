# Ruboty::FlexibleAlias


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruboty-flexible_alias'
```

And then execute:

    $ bundle

## Usage

### Register new alias

```
ruboty flexible [scoped] alias (original) -> (aliased)

# ex:

ruboty flexible alias hi (alnum) -> echo Hello, $1

ruboty hi rosylilly
> Hello, rosylilly

# ex: scoped (availabled alias in registered room only)

ruboty flexible scoped alias bye (alnum) -> echo Good bye, $1

ruboty bye rosylilly
> Good bye, rosylilly
```

Available matchers

- `(alnum)` : `[[:alnum:]]`
- `(digit)` : `[[:digit:]]`
- `(graph)` : `[[:graph:]]`

### Help

```
ruboty /list flexible alias\z/ - List flexible alias
ruboty /delete flexible alias (?<alias>.+)\z/m - Delete flexible alias
ruboty /flexible alias (?<original>.+?) -> (?<alias>.+)\z/m - Create flexible alias message
ruboty /flexible scoped alias (?<original>.+?) -> (?<alias>.+)\z/m - Create flexible alias message
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zeny-io/ruboty-flexible_alias.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

