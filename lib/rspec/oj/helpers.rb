# frozen_string_literal: true

require 'oj'

module RSpec
  module Oj
    module Helpers
      extend self

      def parse_json(json, path = nil)
        return parse_json(generate_normalized_json(json), path) unless json.is_a?(String)

        ruby = ::Oj.load("[#{json}]", mode: :compat).first
        value_at_json_path(ruby, path)
      rescue EncodingError
        begin
          ::Oj.load(json)
        rescue ::Oj::ParseError
          json
        end
      end

      def normalize_json(json, path = nil)
        ruby = parse_json(json, path)
        generate_normalized_json(ruby)
      end

      def generate_normalized_json(ruby)
        case ruby
        when Hash, Array
          ::Oj.dump(ruby, mode: :compat)
        else
          ::Oj.to_json(ruby, mode: :compat)
        end
      end

      def load_json(relative_path)
        missing_json_directory! unless RSpec::Oj.directory
        path = File.join(RSpec::Oj.directory, relative_path)
        missing_json_file!(path) unless File.exist?(path)
        File.read(path)
      end

      private

      def value_at_json_path(ruby, path)
        return ruby unless path

        path.split('/').reduce(ruby) do |memo, key|
          case memo
          when Hash
            memo.fetch(key) { missing_json_path!(path) }
          when Array
            missing_json_path!(path) unless /^\d+$/.match?(key)
            memo.fetch(key.to_i) { missing_json_path!(path) }
          else
            missing_json_path!(path)
          end
        end
      end

      def missing_json_path!(path)
        raise RSpec::Oj::MissingPath, path
      end

      def missing_json_directory!
        raise RSpec::Oj::MissingDirectory
      end

      def missing_json_file!(path)
        raise RSpec::Oj::MissingFile, path
      end
    end
  end
end
