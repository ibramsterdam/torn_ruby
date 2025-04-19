# frozen_string_literal: true

require "uri"
require "net/http"
require "json"
require_relative "base"

module TornRuby
  module Endpoints
    # Responsible for interacting with the Torn City API's key endpoint.
    class Key < Base
      AVAILABLE_FIELDS = %i[info].freeze
    end
  end
end
