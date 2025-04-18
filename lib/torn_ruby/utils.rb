# frozen_string_literal: true

module TornRuby
  # Utility methods for common operations used within the TornRuby gem
  module Utils
    # Thank you ActiveSupport for this great method :-)
    def deep_symbolize_keys(obj)
      case obj
      when Hash
        obj.each_with_object({}) do |(k, v), result|
          result[k.to_sym] = deep_symbolize_keys(v)
        end
      when Array
        obj.map { |e| deep_symbolize_keys(e) }

      else
        obj
      end
    end

    module_function :deep_symbolize_keys
  end
end
