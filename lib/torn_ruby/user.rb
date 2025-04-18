# frozen_string_literal: true

require_relative "utils"

module TornRuby
  class User
    def initialize(data)
      symbolized_data = TornRuby::Utils.deep_symbolize_keys(data)

      symbolized_data.each do |key, value|
        define_singleton_method(key) { instance_variable_get("@#{key}") } unless respond_to?(key)
        instance_variable_set("@#{key}", value)
      end
    end
  end
end
