# frozen_string_literal: true

module RSpec
  module Oj
    module Messages
      def message_with_path(message)
        message = +message << %( at path "#{@path}") if @path
        message
      end
    end
  end
end
