require "r_creds/version"
require_relative "r_creds/fetcher"

module RCreds
  def self.fetch(*keys, default: nil)
    Fetcher.new(keys, default).call
  end
end
