# frozen_string_literal: true

require 'set'

module RSpec
  module Oj
    module Configuration
      DEFAULT_EXCLUDED_KEYS = %w[id created_at updated_at].freeze

      attr_accessor :directory

      def configure(&block)
        instance_eval(&block)
      end

      def excluded_keys
        @excluded_keys ||= DEFAULT_EXCLUDED_KEYS
      end

      def excluded_keys=(keys)
        @excluded_keys = keys.map(&:to_s).uniq
      end

      def exclude_keys(*keys)
        self.excluded_keys = keys
      end

      def reset
        instance_variables.each { |ivar| remove_instance_variable(ivar) }
      end
    end
  end
end
