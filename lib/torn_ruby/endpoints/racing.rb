# frozen_string_literal: true

require "uri"
require "net/http"
require "json"
require_relative "base"

module TornRuby
  module Endpoints
    # Responsible for interacting with the Torn City API's racing endpoint.
    # It provides methods to fetch racing-related data based on an API key, along with optional selections
    # for specific fields to retrieve.
    class Racing < Base
      AVAILABLE_FIELDS = %i[ cars carupgrades race races records
                             tracks lookup timestamp ].freeze
    end
  end
end
