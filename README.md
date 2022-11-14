# RCreds v1.3.0 - [changelog](https://github.com/coaxsoft/r_creds/blob/master/CHANGELOG.md)

RCreds makes working with Rails 5.2/6/7 credentials easier

## Tested on second ruby versions

- 2.7.3
- 3.0.0
- 3.1.1

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'r_creds'
```

And then execute:

```ruby
bundle install
```

Or install it yourself as:

```ruby
gem install r_creds
```

Run the generator:

```ruby
rails generate r_creds:install
```

## Usage

There are no need to do this:

```ruby
Rails.application.credentials[Rails.env.to_sym][:aws][:access_key_id]
```

Use RCreds instead:

```ruby
RCreds.fetch(:aws, :access_key_id)
```

RCreds give an ability to read credentials in credentials.yml, ENV or use default value!
RCreds searches for values in following order: credentials.yml > ENV > default and returns nil if nothing match.

```ruby
# value set in credentials.yml
RCreds.fetch(:aws, :access_key_id) # output: secret_key_from_credentials_yaml
# cred > env

# no value in credentials.yml but
ENV['AWS_ACCESS_KEY_ID'] = 'aws_key_from_env_variable'
RCreds.fetch(:aws, :access_key_id) # output: aws_key_from_env_variable
# cred > env 

# value set in credentials.yml and ENV
RCreds.fetch(:aws, :access_key_id, environment_first: true) # output: aws_key_from_env_variable
# env > cred

# no value in credentials.yml and ENV - use default
RCreds.fetch(:aws, :access_key_id, default: 'some_default_test_key') # output: some_default_test_key
# cred > env > default

# no value in credentials.yml and ENV and without default
RCreds.fetch(:aws, :access_key_id, allow_nil_value: true) # output: raise an error
# cred > env > default > error
```

## Generates quantum computed secret

If you want to generate quantum secret use this generator:

```ruby
rails g r_creds:quantum_secret
```

More info [Quantum random numbers](https://qrng.anu.edu.au)

## DEPRECATED

`Rails 6 loads only one specific environment credentials and does not allow to cahnge it.`

RCreds uses `Rails.env` to determinate environment. But you can set any environment.

```ruby
RCreds.fetch(:aws, :access_key_id, environment: 'production')
```

Will be removed in next version

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at this [link](https://github.com/coaxsoft/r_creds). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RCreds project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/coaxsoft/r_creds/blob/master/CODE_OF_CONDUCT.md).

## Idea

Initially designed and created by [Orest Falchuk](https://github.com/OrestF)
