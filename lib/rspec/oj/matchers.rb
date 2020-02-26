# frozen_string_literal: true

require 'rspec/oj/matchers/be_json_eql'
require 'rspec/oj/matchers/include_json'
require 'rspec/oj/matchers/have_json_path'
require 'rspec/oj/matchers/have_json_type'
require 'rspec/oj/matchers/have_json_size'

module RSpec
  module Oj
    module Matchers
      def be_json_eql(json = nil)
        RSpec::Oj::Matchers::BeJsonEql.new(json)
      end

      def include_json(json = nil)
        RSpec::Oj::Matchers::IncludeJson.new(json)
      end

      def have_json_path(path) # rubocop:disable Naming/PredicateName
        RSpec::Oj::Matchers::HaveJsonPath.new(path)
      end

      def have_json_type(type) # rubocop:disable Naming/PredicateName
        RSpec::Oj::Matchers::HaveJsonType.new(type)
      end

      def have_json_size(size) # rubocop:disable Naming/PredicateName
        RSpec::Oj::Matchers::HaveJsonSize.new(size)
      end
    end
  end
end

RSpec.configure do |config|
  config.include RSpec::Oj::Matchers
end
