# frozen_string_literal: true

require "uri"
require "net/http"
require "json"

module TornRuby
  module Endpoints
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

      def valid_fields?(fields)
        fields.all? { |field| AVAILABLE_FIELDS.include?(field) }
      end

      def fetch(id: nil, selections: nil)
        if selections && !valid_fields?(selections)
          raise TornRuby::Error, "Invalid fields requested. Available fields are: #{AVAILABLE_FIELDS.join(", ")}"
        end

        params = []
        params << "selections=#{selections.join(",")}" if selections

        params << "key=#{@api_key}"

        path = "/user"
        path += "/#{id}" if id
        uri = URI("https://api.torn.com#{path}?#{params.join("&")}")

        response = Net::HTTP.get_response(uri)

        unless response.is_a?(Net::HTTPSuccess)
          raise TornRuby::Error, "API request failed: #{response.code} #{response.message}"
        end

        JSON.parse(response.body)
      end
    end
  end
end
