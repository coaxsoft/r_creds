# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'r_creds/version'

Gem::Specification.new do |spec|
  spec.name          = 'r_creds'
  spec.version       = RCreds::VERSION
  spec.authors       = ['OrestF']
  spec.email         = ['falchuko@gmail.com']

  spec.summary       = 'RCreds makes working with Rails 5.2 credentials easier'
  spec.description   = 'RCreds makes working with Rails 5.2 credentials easier'
  spec.homepage      = 'https://github.com/coaxsoft/r_creds'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.5'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  # spec.files = Dir.chdir(File.expand_path(__dir__)) do
  #   `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.files = Dir['README.md', 'lib/**/*', 'lib/*', 'r_creds.gemspec']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'railties', '~> 7.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.11'
  spec.add_development_dependency 'rubocop', '~> 1.27'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.9'
  spec.add_development_dependency 'simplecov', '~> 0.16'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
