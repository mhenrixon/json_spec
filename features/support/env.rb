# frozen_string_literal: true

$LOAD_PATH << File.expand_path('../../lib', __dir__)

require 'rspec/oj/cucumber'

RSpec::Oj.directory = File.expand_path('../../spec/support/files', __dir__)

def last_json
  @last_json.to_s
end
