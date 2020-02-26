# frozen_string_literal: true

module RSpec
  module Oj
    module Exclusion
      module_function

      def exclude_keys(ruby)
        case ruby
        when Hash
          ruby.sort.each_with_object({}) do |(key, value), hash|
            hash[key] = exclude_keys(value) unless exclude_key?(key)
          end
        when Array
          ruby.map { |v| exclude_keys(v) }
        else ruby
        end
      end

      def exclude_key?(key)
        excluded_keys.include?(key)
      end

      def excluded_keys
        @excluded_keys ||= Set.new(RSpec::Oj.excluded_keys)
      end
    end
  end
end
