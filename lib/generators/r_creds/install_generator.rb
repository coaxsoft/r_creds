# frozen_string_literal: true

require 'rails/generators'

module RCreds
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __dir__)
      desc 'Generates config file.'

      def copy_config
        template 'r_creds_initializer.rb', "#{Rails.root}/config/initializers/r_creds.rb"
      end
    end
  end
end
