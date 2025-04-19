# frozen_string_literal: true

module TornRuby
  # A base class for models that encapsulates data and handles the initialization of attributes.
  class Base
    def initialize(data)
      symbolized_data = TornRuby::Utils.deep_symbolize_keys(data)

      symbolized_data.each do |key, value|
        define_singleton_method(key) { instance_variable_get("@#{key}") } unless respond_to?(key)
        instance_variable_set("@#{key}", value)
      end
    end
  end
end
