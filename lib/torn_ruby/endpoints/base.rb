# frozen_string_literal: true

require "uri"
require "net/http"
require "json"

module TornRuby
  module Endpoints
    # Base class for all endpoints
    class Base
      BASE_URL = "https://api.torn.com/v2"

      def initialize(api_key)
        @api_key = api_key
      end

      def fetch(path: nil, selections: nil)
        selections = [] if selections.nil?

        raise TornRuby::Error, "Invalid fields selected" if respond_to?(:valid_fields?) && !valid_fields?(selections)

        params = build_params(selections)
        path = build_path(path)
        handle_response(make_request(build_uri(path, params)))
      end

      def valid_fields?(fields)
        fields.all? { |field| self.class::AVAILABLE_FIELDS.include?(field) }
      end

      private

      def build_params(selections)
        params = ["key=#{@api_key}"]
        params << "selections=#{selections.join(",")}" if selections
        params
      end

      def build_uri(path, params)
        URI("#{BASE_URL}#{path}?#{params.join("&")}")
      end

      def build_path(path)
        full_path = "/#{self.class.name.split("::").last.downcase}"
        full_path += "/#{path}" if path
        full_path
      end

      def make_request(uri)
        Net::HTTP.get_response(uri)
      end

      def handle_response(response)
        unless response.is_a?(Net::HTTPSuccess)
          raise TornRuby::Error, "API request failed: #{response.code} #{response.message}"
        end

        JSON.parse(response.body)
      end
    end
  end
end
