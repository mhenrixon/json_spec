# frozen_string_literal: true

module RSpec
  module Oj
    module Matchers
      class BeJsonEql
        include RSpec::Oj::Helpers
        include RSpec::Oj::Exclusion
        include RSpec::Oj::Messages

        attr_reader :expected, :actual

        def diffable?
          true
        end

        def initialize(expected_json = nil)
          @expected_json = expected_json
          @path = nil
        end

        def matches?(actual_json)
          raise 'Expected equivalent JSON not provided' if @expected_json.nil?

          @actual = scrub(actual_json, @path)
          @expected = scrub(@expected_json)
          @actual == @expected
        end

        def at_path(path)
          @path = path
          self
        end

        def to_file(path)
          @expected_json = load_json(path)
          self
        end

        def excluding(*keys)
          excluded_keys.merge(keys.map(&:to_s))
          self
        end

        def including(*keys)
          excluded_keys.subtract(keys.map(&:to_s))
          self
        end

        def failure_message
          message_with_path('Expected equivalent JSON')
        end
        alias failure_message_for_should failure_message

        def failure_message_when_negated
          message_with_path('Expected inequivalent JSON')
        end
        alias failure_message_for_should_not failure_message_when_negated

        def description
          message_with_path('equal JSON')
        end

        private

        def scrub(json, path = nil)
          generate_normalized_json(exclude_keys(parse_json(json, path))).chomp + "\n"
        end
      end
    end
  end
end
