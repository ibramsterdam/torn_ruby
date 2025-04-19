# frozen_string_literal: true

require "uri"
require "net/http"
require "json"
require_relative "base"

module TornRuby
  module Endpoints
    # Responsible for interacting with the Torn City API's market endpoint.
    # It provides methods to fetch market data based on an API key, along with optional selections
    # for specific fields to retrieve. The class ensures that only valid fields are requested
    # from the API and handles the response by parsing the JSON data into a usable format.
    class Market < Base
      AVAILABLE_FIELDS = %w[bazaar itemmarket lookup pointsmarket timestamp].freeze

      def valid_fields?(fields)
        fields.all? { |field| AVAILABLE_FIELDS.include?(field) }
      end
    end
  end
end
