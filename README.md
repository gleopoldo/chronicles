# Chronicles

Aarg! This project is fot those with brave hearts, those who never flee a fight!

Do you want to join on a incredible adventure? Want to have your name placed
in the hall of fame, or remembered by the history?

This is the right place!

We have several bots designed using actor models and an erlang-like interfaces
whose message trading is responsible for creating random events that compose an 
epic journey using a Middle Ages theme.

Each time you join a new journey, a new, completely different end may arrise.

But hands on! Nobody would care about this unless you could have your epics 
narrated by a bard - those guys from the middle age that were paid to tell
histories about someone greatest deeds.

Are you lucky enought to create an epic journey? Try it yourself.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'chronicles'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chronicles

## Usage

Running in development:

```
bin/run
```

Sending e-mails for people you like:

```
SMTP_USER=<user> SMTP_PASSWORD=<password> SMTP_ADDRESS=<host> SMTP_PORT=<port> bin/run --recipient <e-mail>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/chronicles. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Chronicles project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/chronicles/blob/master/CODE_OF_CONDUCT.md).
