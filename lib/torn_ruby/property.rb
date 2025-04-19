# frozen_string_literal: true

require_relative "utils"
require_relative "base"

module TornRuby
  # Responsible for representing a property in the Torn City game.
  # It encapsulates property data retrieved from the Torn City API
  class Property < Base
    def living_user_ids
      users_living.split(",").map(&:to_i)
    end

    def rented?
      rented.is_a?(Hash)
    end
  end
end
