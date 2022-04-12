# frozen_string_literal: true

require 'r_creds/version'
require_relative 'r_creds/fetcher'

module RCreds
  class << self
    attr_writer :environment_first, :allow_nil_value

    def environment_first
      @environment_first || false
    end

    def allow_nil_value
      @allow_nil_value || true
    end

    def config
      yield self
    end

    def fetch(*keys,
              default: nil,
              environment: nil,
              environment_first: self.environment_first,
              allow_nil_value: self.allow_nil_value)

      Fetcher.new(keys, default, environment, environment_first, allow_nil_value).call
    end
  end
end
