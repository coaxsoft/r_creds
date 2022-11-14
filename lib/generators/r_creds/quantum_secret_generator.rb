# frozen_string_literal: true

require 'rails/generators'

module RCreds
  module Generators
    class QuantumSecretGenerator < Rails::Generators::Base
      BASE_URL = 'https://qrng.anu.edu.au/API/jsonI.php'

      desc 'Generates quantum computed secret.'

      uri = URI(BASE_URL)
      uri.query = URI.encode_www_form({ length: 1, type: 'hex16', size: 64 })

      Net::HTTP.get_response(uri).then do |response|
        if response.is_a?(Net::HTTPSuccess)
          puts JSON.parse(response.body)['data'][0]
        else
          puts "Service(#{BASE_URL}) is unavailable"
        end
      end

    end
  end
end
