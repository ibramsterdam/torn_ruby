# frozen_string_literal: true

require_relative "utils"

module TornRuby
  # Responsible for representing a property in the Torn City game.
  # It encapsulates property data retrieved from the Torn City API
  class Property
    attr_reader :owner_id, :property_type, :happy, :upkeep,
                :upgrades, :staff, :rented, :users_living

    def initialize(data)
      symbolized_data = TornRuby::Utils.deep_symbolize_keys(data)

      @owner_id = symbolized_data[:owner_id]
      @property_type = symbolized_data[:property_type]
      @happy = symbolized_data[:happy]
      @upkeep = symbolized_data[:upkeep]
      @upgrades = symbolized_data[:upgrades]
      @staff = symbolized_data[:staff]
      @rented = symbolized_data[:rented]
      @users_living = symbolized_data[:users_living]
    end

    def living_user_ids
      users_living.split(",").map(&:to_i)
    end

    def rented?
      rented.is_a?(Hash)
    end
  end
end
