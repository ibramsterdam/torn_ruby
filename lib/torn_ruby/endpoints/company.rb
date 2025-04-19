# frozen_string_literal: true

require "uri"
require "net/http"
require "json"
require_relative "base"

module TornRuby
  module Endpoints
    # Responsible for interacting with the Torn City API's company endpoint.
    # It provides methods to fetch faction data based on an API key, along with optional selections
    # for specific fields to retrieve. The class ensures that only valid fields are requested
    # from the API and handles the response by parsing the JSON data into a usable format.
    class Company < Base
      AVAILABLE_FIELDS = %w[
        companies lookup profile timestamp applications detailed
        employees news stock
      ].freeze

      def valid_fields?(fields)
        fields.all? { |field| AVAILABLE_FIELDS.include?(field) }
      end
    end
  end
end
