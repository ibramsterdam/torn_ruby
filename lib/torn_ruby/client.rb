# frozen_string_literal: true

require_relative "endpoints/user"
require_relative "endpoints/property"
require_relative "user"
require_relative "property"

module TornRuby
  # Responsible for interacting with the Torn API
  # and providing an interface to access various endpoints.
  class Client
    def initialize(api_key:)
      @api_key = api_key
    end

    def user(id: nil, selections: nil)
      data = TornRuby::Endpoints::User.new(@api_key).fetch(id: id, selections: selections)
      TornRuby::User.new(data)
    end

    def property(id: nil, selections: nil)
      data = TornRuby::Endpoints::Property.new(@api_key).fetch(id: id, selections: selections)
      TornRuby::Property.new(data)
    end
  end
end
