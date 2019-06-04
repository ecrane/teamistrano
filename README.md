# Teamistrano

The Teamistrano gem can be used to post Capistrano deployment notices in Microsoft Teams.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'teamistrano'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install teamistrano


## Usage

In Teams, add an "Incoming Webhook" connector in the channel where you want to see deployment notices.  Copy the webhook URL that is created when you add the connector.

In your config/deploy.rb file add the webhook URL like this:

```
set :teamistrano, {
  webhook: 'https://outlook.office.com/webhook/.....'
}
```

Add a reference in the Capfile:

```
require 'teamistrano'
```

Stand up, turn around three times and then do your 'cap deploy'.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ecrane/teamistrano. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Teamistrano project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ecrane/teamistrano/blob/master/CODE_OF_CONDUCT.md).
