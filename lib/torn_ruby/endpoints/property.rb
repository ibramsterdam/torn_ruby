# frozen_string_literal: true

require "uri"
require "net/http"
require "json"
require_relative "base"

module TornRuby
  module Endpoints
    # Responsible for interacting with the Torn City API's user endpoint.
    # It provides methods to fetch user data based on an API key, along with optional selections
    # for specific fields to retrieve. The class ensures that only valid fields are requested
    # from the API and handles the response by parsing the JSON data into a usable format.
    class Property < Base
      AVAILABLE_FIELDS = %i[property].freeze

      private

      def handle_response(response)
        unless response.is_a?(Net::HTTPSuccess)
          raise TornRuby::Error, "API request failed: #{response.code} #{response.message}"
        end

        JSON.parse(response.body)["property"]
      end
    end
  end
end
