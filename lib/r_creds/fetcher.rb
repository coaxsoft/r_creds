module RCreds
  class Fetcher
    class NoRailsError < StandardError; end

    def initialize(keys, default, environment)
      @keys = keys
      @default = default
      @environment = environment
    end

    attr_reader :keys, :default

    def call
      check_rails
      fetch
    end

    private

    def environment
      (presence?(@environment) || Rails.env).to_sym
    end

    def fetch
      cred = Rails.application.credentials.dig(environment, *keys)

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
