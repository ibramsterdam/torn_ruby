# frozen_string_literal: true

require_relative "endpoints/user"
require_relative "endpoints/property"
require_relative "endpoints/faction"
require_relative "endpoints/company"
require_relative "endpoints/market"
require_relative "endpoints/torn"
require_relative "endpoints/racing"
require_relative "endpoints/forum"
require_relative "endpoints/key"
require_relative "user"
require_relative "property"
require_relative "faction"
require_relative "company"
require_relative "market"
require_relative "torn"
require_relative "racing"
require_relative "forum"
require_relative "key"

module TornRuby
  # Responsible for interacting with the Torn API
  # and providing an interface to access various endpoints.
  class Client
    def initialize(api_key:)
      @api_key = api_key
    end

    def user(path: nil, selections: nil)
      data = TornRuby::Endpoints::User.new(@api_key).fetch(path:, selections:)
      TornRuby::User.new(data)
    end

    def property(path: nil, selections: nil)
      data = TornRuby::Endpoints::Property.new(@api_key).fetch(path:, selections:)
      TornRuby::Property.new(data)
    end

    def faction(path: nil, selections: nil)
      data = TornRuby::Endpoints::Faction.new(@api_key).fetch(path:, selections:)
      TornRuby::Faction.new(data)
    end

    def company(path: nil, selections: nil)
      data = TornRuby::Endpoints::Company.new(@api_key).fetch(path:, selections:)
      TornRuby::Company.new(data)
    end

    def market(path: nil, selections: nil)
      data = TornRuby::Endpoints::Market.new(@api_key).fetch(path:, selections:)
      TornRuby::Company.new(data)
    end

    def torn(path: nil, selections: nil)
      data = TornRuby::Endpoints::Torn.new(@api_key).fetch(path:, selections:)
      TornRuby::Torn.new(data)
    end

    def racing(path: nil, selections: nil)
      data = TornRuby::Endpoints::Racing.new(@api_key).fetch(path:, selections:)
      TornRuby::Racing.new(data)
    end

    def forum(path: nil, selections: nil)
      data = TornRuby::Endpoints::Forum.new(@api_key).fetch(path:, selections:)
      TornRuby::Forum.new(data)
    end

    def key(path: nil, selections: nil)
      data = TornRuby::Endpoints::Key.new(@api_key).fetch(path:, selections:)
      TornRuby::Key.new(data)
    end
  end
end
