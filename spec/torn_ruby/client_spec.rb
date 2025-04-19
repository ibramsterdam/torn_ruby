# frozen_string_literal: true

require "spec_helper"

RSpec.describe TornRuby::Client do
  let(:api_key) { "test_api_key" }
  let(:client) { described_class.new(api_key: api_key) }

  describe "#user" do
    subject(:user) { client.user }

    let(:mock_response) do
      {
        "rank" => "Star Trader",
        "level" => 37,
        "name" => "Bram",
        "life" => {
          "current" => 1725,
          "maximum" => 1725
        }
      }
    end

    before do
      user_endpoint = instance_double(TornRuby::Endpoints::User)
      allow(TornRuby::Endpoints::User).to receive(:new).and_return(user_endpoint)
      allow(user_endpoint).to receive(:fetch).and_return(mock_response)
    end

    it "returns a TornRuby::User with expected attributes" do
      expect(user).to be_a(TornRuby::User)
        .and have_attributes(
          rank: "Star Trader",
          level: 37,
          name: "Bram",
          life: hash_including(
            current: 1725,
            maximum: 1725
          )
        )
    end
  end

  describe "#property" do
    subject(:property) { client.property }

    let(:mock_response) do
      {
        "owner_id" => 123_456,
        "property_type" => 5,
        "happy" => 9000,
        "upkeep" => 100_000,
        "upgrades" => %w[pool gym],
        "staff" => %w[maid guard],
        "rented" => false,
        "users_living" => "123456,654321"
      }
    end

    before do
      property_endpoint = instance_double(TornRuby::Endpoints::Property)

      allow(TornRuby::Endpoints::Property).to receive(:new).and_return(property_endpoint)
      allow(property_endpoint).to receive(:fetch).and_return(mock_response)
    end

    it "returns a TornRuby::Property with expected attributes" do
      expect(property).to be_a(TornRuby::Property)
        .and have_attributes(
          owner_id: 123_456,
          property_type: 5,
          happy: 9000,
          upkeep: 100_000,
          upgrades: %w[pool gym],
          staff: %w[maid guard],
          rented: false,
          users_living: "123456,654321"
        )
    end

    it "parses living user ids correctly" do
      expect(property.living_user_ids).to eq([123_456, 654_321])
    end

    it "returns false for rented?" do
      expect(property.rented?).to be(false)
    end
  end

  describe "#faction" do
    subject(:faction) { client.faction }

    let(:mock_response) do
      {
        "ID" => 38_761,
        "name" => "Shadow Healers",
        "respect" => 2_450_100,
        "rank" => {
          "level" => 9,
          "name" => "Silver",
          "division" => 3
        }
      }
    end

    before do
      faction_endpoint = instance_double(TornRuby::Endpoints::Faction)
      allow(TornRuby::Endpoints::Faction).to receive(:new).and_return(faction_endpoint)
      allow(faction_endpoint).to receive(:fetch).and_return(mock_response)
    end

    it "returns a TornRuby::Faction with expected attributes" do
      expect(faction).to be_a(TornRuby::Faction)
        .and have_attributes(
          ID: 38_761,
          name: "Shadow Healers",
          respect: 2_450_100,
          rank: hash_including(
            level: 9,
            name: "Silver",
            division: 3
          )
        )
    end
  end
end
