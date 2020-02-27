# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec/oj/version'

Gem::Specification.new do |spec|
  spec.name        = 'rspec-oj'
  spec.version     = RSpec::Oj::VERSION
  spec.authors     = ['Mikael Henriksson']
  spec.email       = ['mikael@mhenrixon.com']
  spec.summary     = 'Easily handle JSON in RSpec and Cucumber'
  spec.description = 'RSpec matchers and Cucumber steps for testing JSON content'
  spec.homepage    = 'https://github.com/mhenrixon/rspec-oj'
  spec.license     = 'MIT'

  spec.add_dependency 'oj', '~> 3.0'
  spec.add_dependency 'rspec', '>= 3.0', '< 5.0'

  spec.add_development_dependency 'bundler',            '~> 2.1'
  spec.add_development_dependency 'gem-release',        '~> 2.1'
  spec.add_development_dependency 'pry',                '~> 0.12.2'
  spec.add_development_dependency 'rake',               '~> 13.0'
  spec.add_development_dependency 'reek',               '~> 5.0'
  spec.add_development_dependency 'rubocop-mhenrixon',  '~> 0.80.0'
  spec.add_development_dependency 'simplecov',          '~> 0.17.0'
  spec.add_development_dependency 'simplecov-oj',       '~> 0.18.0'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").select do |file|
      file.match(%r{^(lib/*|README|LICENSE)})
    end
  end
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(spec|features)/)
  spec.require_paths = ['lib']
end
