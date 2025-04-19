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
    class User < Base
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
    end
  end
end
