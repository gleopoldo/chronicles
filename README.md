# Chronicles

Aarg! This project is for those with brave hearts, those who never flees a 
fight!

Do you want to join on an incredible adventure? Want to have your name 
in the books of history? Want to be accepted in Valhalla?

This is the right place!

We have several bots designed using actor models and an erlang-like interface
whose message trading is responsible for creating random events that compose an 
epic journey using a Middle Ages theme.

Each time you join a new journey, a new, completely different, end may arrise.

But hands on! Nobody would even know you unless a bard is hired to tell
about your deeds. So, you can hire a bard to write about your epic adventures
and send e-mails to everyone in the world about your journey.
With luck even Odin will hear about your deeds.

So, are you lucky enought to create an epic journey? Try it yourself.

## Installation

I don't have published this project as a gem, but you can clone the project
in your host and do a quick setup to have everything up and running:

```
./scripts/chronicles setup
```

This only requires you to have docker installed. Everything should
go fine from there.

## Usage

In order to run this app, you can bring up the Chronicles Server using either
the CLI or by accessing a bash console and manually bringing it up. Let's try
the first option:

```
./scripts/chronicles run
```

By running this command, a new TCP server will be listening on localhost
at port 40000. You can start a new adventure by using telnet:

```
telnet 0 40000
Trying 0.0.0.0...
Connected to 0.
Escape character is '^]'.
I don't know you yet! What's your name?
Olaf
Olaf joined a travel to the New World... The objective? Just be a viking!
... and here we go!
```

You can also run the server manually by accessing the bash console in the 
container:

```
./scripts/chronicles bash
```

Then, you can start the server running the command bellow from within the
bash console in the container.

```
bin/run
```

##### Sharing your adventure with the world

We can hire a harald to help you send an e-mail to people in the other
side of the world, but instead of paying with coins you must pay with
a few settings:

```
SMTP_USER=<user> SMTP_PASSWORD=<password> SMTP_ADDRESS=<host> SMTP_PORT=<port> bin/run --recipient <e-mail>
```

### Development

After checking out the repo, run `./scripts/chronicles setup` to install
dependencies. Then, run `./scripts/chronicles bash` to bring up a docker
container with everything ready for you.

Run the tests with `bundle exec rspec`.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/[USERNAME]/chronicles. This project is intended to be a
safe, welcoming space for collaboration, and contributors are expected to
adhere to the [Contributor Covenant](http://contributor-covenant.org)
code of conduct.

## License

The project is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Chronicles project’s codebases, issue trackers,
chat rooms and mailing lists is expected to follow the
[code of conduct](https://github.com/[USERNAME]/chronicles/blob/master/CODE_OF_CONDUCT.md).
