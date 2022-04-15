# frozen_string_literal: true

module RCreds
  class Fetcher
    class NoRailsError < StandardError; end
    class NilValueError < StandardError; end

    def initialize(keys, default, environment, environment_first, allow_nil_value)
      @keys = keys.map!(&:to_sym)
      @default = default
      @environment = environment
      @environment_first = environment_first
      @allow_nil_value = allow_nil_value
    end

    attr_reader :keys, :default, :environment_first, :allow_nil_value, :cred_value

    def call
      check_rails
      fetch
    end

    private

    def environment
      (presence?(@environment) || Rails.env).to_sym
    end

    def check_rails
      return define_rails_strategy && true if defined?(::Rails)

      no_rails_error!
    end

    def fetch
      define_cred_value

      nil_value_error! if cred_value.nil? && !allow_nil_value

      cred_value
    end

    def define_cred_value
      cred = send("fetch_rails#{@rails_version}")
      env = ENV[keys.join('_').upcase]

      @cred_value = if environment_first.present?
                      presence?(env) || presence?(cred) || default
                    else
                      presence?(cred) || presence?(env) || default
                    end
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

    def define_rails_strategy
      @rails_version = Rails.version.to_i
    end

    def fetch_rails5
      Rails.application.credentials.dig(environment, *keys)
    end

    def fetch_rails6
      if rails6_multi_env?
        show_warning if presence?(@environment)
        Rails.application.credentials.dig(*keys)
      else
        Rails.application.credentials.dig(environment, *keys)
      end
    end
    alias fetch_rails7 fetch_rails6

    def rails6_multi_env?
      Rails.application.credentials.content_path.basename.to_s != 'credentials.yml.enc'
    end

    def show_warning
      puts "WARNING! Environment choice does not work in Rails >= 6. Fetching credentials for '#{Rails.env}'"
    end

    def nil_value_error!
      raise NilValueError, "can not find existing value by that keys -> #{keys}"
    end

    def no_rails_error!
      raise NoRailsError, 'RCreds works with 5.2 and above'
    end
  end
end
