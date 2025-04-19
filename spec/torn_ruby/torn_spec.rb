# frozen_string_literal: true

require "spec_helper"

RSpec.describe TornRuby::Torn do
  subject(:torn) { described_class.new(data) }

  let(:data) do
    {
      "bounties" => [
        {
          "target_id" => 2_556_147,
          "target_name" => "salakau",
          "target_level" => 36,
          "lister_id" => 2_932_719,
          "lister_name" => "Ridyard",
          "reward" => 1_000_000,
          "reason" => nil,
          "quantity" => 1,
          "is_anonymous" => false,
          "valid_until" => 1_745_619_969
        },
        {
          "target_id" => 2_367_908,
          "target_name" => "N4Z4",
          "target_level" => 55,
          "lister_id" => 1_313_583,
          "lister_name" => "Nurgle",
          "reward" => 1_000_000,
          "reason" => nil,
          "quantity" => 4,
          "is_anonymous" => false,
          "valid_until" => 1_745_656_140
        }
      ]
    }
  end

  describe "#bounties" do
    it "returns an array of bounties and correctly handles each bounty's attributes" do
      expect(torn.bounties).to contain_exactly(hash_including(
                                                 target_id: 2_556_147,
                                                 target_name: "salakau",
                                                 target_level: 36,
                                                 lister_id: 2_932_719,
                                                 lister_name: "Ridyard",
                                                 reward: 1_000_000,
                                                 reason: nil,
                                                 quantity: 1,
                                                 is_anonymous: false,
                                                 valid_until: 1_745_619_969
                                               ), hash_including(
                                                    target_id: 2_367_908,
                                                    target_name: "N4Z4",
                                                    target_level: 55,
                                                    lister_id: 1_313_583,
                                                    lister_name: "Nurgle",
                                                    reward: 1_000_000,
                                                    reason: nil,
                                                    quantity: 4,
                                                    is_anonymous: false,
                                                    valid_until: 1_745_656_140
                                                  ))
    end

    it "does not define methods for missing keys" do
      expect(torn).not_to respond_to(:nonexistent_key)
    end
  end
end
