require "r_creds/version"
require_relative "r_creds/fetcher"

module RCreds
  def self.fetch(*keys, default: nil, environment: nil)
    Fetcher.new(keys, default, environment).call
  end
end
