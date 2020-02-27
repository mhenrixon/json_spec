# frozen_string_literal: true

require 'rspec/oj/errors'
require 'rspec/oj/configuration'
require 'rspec/oj/exclusion'
require 'rspec/oj/helpers'
require 'rspec/oj/messages'
require 'rspec/oj/matchers'
require 'rspec/oj/memory'

module RSpec
  module Oj
    extend Configuration
    extend Memory
  end
end
