# frozen_string_literal: true

require_relative "endpoints/user"
require_relative "user"

module TornRuby
  # Responsible for interacting with the Torn API
  # and providing an interface to access various endpoints.
  class Client
    BASE_URL = "https://api.torn.com"

    def initialize(api_key:)
      @api_key = api_key
    end

    def user(id: nil, selections: nil)
      data = TornRuby::Endpoints::User.new(@api_key).fetch(id: id, selections: selections)
      TornRuby::User.new(data)
    end
  end
end
