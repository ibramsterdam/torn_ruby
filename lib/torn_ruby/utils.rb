# frozen_string_literal: true

module TornRuby
  # Utility methods for common operations used within the TornRuby gem
  module Utils
    # Thank you ActiveSupport for this great method :-)
    def deep_symbolize_keys(obj)
      case obj
      when Hash
        symbolize_hash(obj)
      when Array
        obj.map { |e| deep_symbolize_keys(e) }
      else
        obj
      end
    end

    def symbolize_hash(hash)
      hash.each_with_object({}) do |(k, v), result|
        key = symbolize_key(k)
        result[key] = deep_symbolize_keys(v)
      end
    end

    def symbolize_key(key)
      # Only convert key to symbol if it's a non-numeric string
      key.is_a?(String) && key !~ /^\d+$/ ? key.to_sym : key
    end

    module_function :deep_symbolize_keys, :symbolize_hash, :symbolize_key
  end
end
