# frozen_string_literal: true

require "uri"
require "net/http"
require "json"
require_relative "base"

module TornRuby
  module Endpoints
    # Responsible for interacting with the Torn City API's torn endpoint.
    class Torn < Base
      AVAILABLE_FIELDS = %i[
        attacklog bounties calendar crimes hof itemammo itemmods subcrimes rankedwarreport rankedwars
        bank cards chainreport cityshops companies competition dirtybombs education factionhof factiontree
        gyms honors itemdetails items itemstats logcategories logtypes lookup medals organisedcrimes pawnshop
        pokertables properties rackets raidreport raids rockpaperscissors searchforcash shoplifting stats
        stocks territory territorynames territorywarreport territorywars timestamp
      ].freeze
    end
  end
end
