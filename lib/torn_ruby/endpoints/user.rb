# frozen_string_literal: true

require "uri"
require "net/http"
require "json"

module TornRuby
  module Endpoints
    # Responsible for interacting with the Torn City API's user endpoint.
    # It provides methods to fetch user data based on an API key, along with optional selections
    # for specific fields to retrieve. The class ensures that only valid fields are requested
    # from the API and handles the response by parsing the JSON data into a usable format.
    class User
      AVAILABLE_FIELDS = %w[
        ammo attacks attacksfull bars basic battlestats bazaar
        calendar cooldowns crimes criminalrecord discord display
        education enlistedcars equipment events factionBalance forumfeed
        forumfriends forumposts forumsubscribedthreads forumthreads gym hof
        honors icons inventory itemmarket jobpoints list log lookup
        medals merits messages missions money networth newevents
        newmessages notifications organizedCrime perks personalstats profile
        properties races refills reports revives revivesfull skills stocks
        timestamp travel weaponexp workstats
      ].freeze

      def initialize(api_key)
        @api_key = api_key
      end

      def fetch(id: nil, selections: nil)
        raise TornRuby::Error, "Invalid fields selected" unless valid_fields?(selections)

        params = build_params(id, selections)
        path = build_path(id)
        handle_response(make_request(build_uri(path, params)))
      end

      private

      def valid_fields?(fields)
        fields.all? { |field| AVAILABLE_FIELDS.include?(field) }
      end

      def build_params(_id, selections)
        params = ["key=#{@api_key}"]
        params << "selections=#{selections.join(",")}" if selections
        params
      end

      def build_path(id)
        path = "/user"
        path += "/#{id}" if id
        path
      end

      def build_uri(path, params)
        URI("https://api.torn.com#{path}?#{params.join("&")}")
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
