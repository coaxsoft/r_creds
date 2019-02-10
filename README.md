# RCreds

RCreds makes working with Rails 5.2 credentials easier

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'r_creds'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install r_creds

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
```ruby
# value set in credentials.yml
RCreds.fetch(:aws, :access_key_id) # output: secret_key_from_credentials_yaml

# no value in credentials.yml but,
ENV['AWS_ACCESS_KEY_ID'] = 'aws_key_from_env_variable'
RCreds.fetch(:aws, :access_key_id) # output: aws_key_from_env_variable

# no value in credentials.yml and ENV - use default
RCreds.fetch(:aws, :access_key_id, default: 'some_default_test_key') # output: some_default_test_key
```
RCreds searches for values in following order: credentials.yml > ENV > default and returns nil if nothing match

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/OrestF/r_creds. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RCreds project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/OrestF/r_creds/blob/master/CODE_OF_CONDUCT.md).
