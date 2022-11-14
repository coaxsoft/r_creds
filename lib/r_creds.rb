# frozen_string_literal: true

require 'r_creds/version'
require 'r_creds/fetcher'

module RCreds
  class << self
    class InvalidTypeError < StandardError; end

    attr_writer :environment_first, :allow_nil_value

    def environment_first
      @environment_first || false
    end

    def allow_nil_value
      @allow_nil_value || true
    end

    def config
      yield_self
    end

    def fetch(*keys,
              default: nil,
              environment: nil,
              environment_first: self.environment_first,
              allow_nil_value: self.allow_nil_value)

      [environment_first, allow_nil_value].each do |attr|
        invalid_type_error! unless [true, false].include?(attr)
      end

      Fetcher.new(keys, default, environment, environment_first, allow_nil_value).call
    end

    private

    def invalid_type_error!
      raise InvalidTypeError, 'only boolean type allowed'
    end
  end
end
