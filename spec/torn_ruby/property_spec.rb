# frozen_string_literal: true

require "spec_helper"

RSpec.describe TornRuby::Property do
  subject(:property) { described_class.new(data) }

  let(:data) do
    {
      "owner_id" => 2_187_512,
      "property_type" => 13,
      "happy" => 5025,
      "upkeep" => 100_000,
      "upgrades" => [
        "Superior interior",
        "Large pool",
        "Extra large vault"
      ],
      "staff" => [
        "5x Maid service",
        "3x Butler service"
      ],
      "rented" => {
        "user_id" => 2_728_237,
        "days_left" => 73,
        "total_cost" => 81_000_000,
        "cost_per_day" => 810_000
      },
      "users_living" => "2725863,2728237"
    }
  end

  it "initializes attributes correctly" do
    expect(property).to have_attributes(
      owner_id: 2_187_512,
      property_type: 13,
      happy: 5025,
      upkeep: 100_000,
      upgrades: include("Superior interior", "Large pool"),
      staff: include("5x Maid service", "3x Butler service"),
      rented: hash_including(user_id: 2_728_237),
      users_living: "2725863,2728237"
    )
  end

  describe "#living_user_ids" do
    it "returns an array of user IDs as integers" do
      expect(property.living_user_ids).to eq([2_725_863, 2_728_237])
    end
  end

  describe "#rented?" do
    it "returns true when rented data is present" do
      expect(property.rented?).to be true
    end
  end
end
