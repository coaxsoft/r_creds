module RCreds
  class Fetcher
    class NoRailsError < StandardError; end

    def initialize(keys, default)
      @keys = keys
      @default = default
    end

    attr_reader :keys, :default

    def call
      check_rails
      fetch
    end

    def fetch
      cred = Rails.application.credentials.dig(Rails.env.to_sym, *keys)

      presence?(cred) || presence?(ENV[keys.join('_').upcase]) || default
    end

    def presence?(cred)
      return nil if cred.nil?

      present?(cred) ? cred : false
    end

    def present?(cred)
      !blank?(cred)
    end

    def blank?(cred)
      cred.respond_to?(:empty?) ? !!cred.empty? : !cred
    end

    def check_rails
      return true if defined?(::Rails)

      raise NoRailsError.new 'RCreds works with 5.2 and above'
    end
  end
end
