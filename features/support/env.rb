# frozen_string_literal: true

$LOAD_PATH << File.expand_path('../lib/rspec', __dir__)

require 'rspec-oj'
require 'rspec/oj/cucumber'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

RSpec::Oj.directory = File.expand_path('../../spec/support/files', __dir__)

def last_json
  @last_json.to_s
end
