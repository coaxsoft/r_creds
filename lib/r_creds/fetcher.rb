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
      cred = send("fetch_rails_#{@rails_version}")

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

    def fetch_rails_5
      Rails.application.credentials.dig(environment, *keys)
    end

    def fetch_rails_6
      Rails.application.credentials.dig(*keys)
    end

    def check_rails
      return define_rails_strategy && true if defined?(::Rails)

      raise NoRailsError.new 'RCreds works with 5.2 and above'
    end

    def define_rails_strategy
      define_instance_variable("@rails_version", Rails.version.to_i)
    end
  end
end
