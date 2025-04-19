# frozen_string_literal: true

require_relative "endpoints/user"
require_relative "endpoints/property"
require_relative "endpoints/faction"
require_relative "endpoints/company"
require_relative "endpoints/market"
require_relative "endpoints/torn"
require_relative "user"
require_relative "property"
require_relative "faction"
require_relative "company"
require_relative "market"
require_relative "torn"

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

    def faction(id: nil, selections: nil)
      data = TornRuby::Endpoints::Faction.new(@api_key).fetch(id: id, selections: selections)
      TornRuby::Faction.new(data)
    end

    def company(id: nil, selections: nil)
      data = TornRuby::Endpoints::Company.new(@api_key).fetch(id: id, selections: selections)
      TornRuby::Company.new(data)
    end

    def market(id: nil, selections: nil)
      data = TornRuby::Endpoints::Market.new(@api_key).fetch(id: id, selections: selections)
      TornRuby::Company.new(data)
    end

    def torn(id: nil, selections: nil)
      data = TornRuby::Endpoints::Torn.new(@api_key).fetch(id: id, selections: selections)
      TornRuby::Torn.new(data)
    end
  end
end
