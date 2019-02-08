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

RCreds give an ability to read credentials in credentials.yml, ENV or use default value!

```ruby
# returns value from credentials.yml for current environment 
RCreds.fetch(:payment_system, :secret_key) 
```
```ruby
# returns value from credentials.yml for current environment or default 
RCreds.fetch(:redis, :url, default: 'redis://localhost:6379/0')
```
```ruby
# if value is set in as ENV variable it will be fetched if it's not set in credentials.yml
# keys concatenates as in following example
ENV['REDIS_URL'] = 'redis://real_redis_url'
RCreds.fetch(:redis, :url, default: 'redis://localhost:6379/0') # output: redis://real_redis_url
```
RCreds search for values in following order: credentials.yml > ENV > default:

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/r_creds. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RCreds project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/r_creds/blob/master/CODE_OF_CONDUCT.md).
