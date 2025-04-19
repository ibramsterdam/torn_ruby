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

  describe "#company" do
    subject(:company) { client.company }

    let(:mock_response) do
      {
        "ID" => 96_842,
        "company_type" => 26,
        "rating" => 8,
        "name" => "Slippery When Wet",
        "director" => 3_391_134,
        "employees_hired" => 10,
        "employees_capacity" => 10,
        "daily_income" => 1_322_838,
        "daily_customers" => 24_009,
        "weekly_income" => 13_071_476,
        "weekly_customers" => 239_180,
        "days_old" => 950,
        "employees" => {
          "207875" => {
            "name" => "wryte",
            "position" => "Manager",
            "days_in_company" => 236,
            "last_action" => {
              "status" => "Offline",
              "timestamp" => 1_744_802_457,
              "relative" => "3 days ago"
            },
            "status" => {
              "description" => "Okay",
              "details" => "",
              "state" => "Okay",
              "color" => "green",
              "until" => 0
            }
          }
        }
      }
    end

    before do
      endpoint = instance_double(TornRuby::Endpoints::Company)
      allow(TornRuby::Endpoints::Company).to receive(:new).and_return(endpoint)
      allow(endpoint).to receive(:fetch).and_return(mock_response)
    end

    it "returns a TornRuby::Company with expected attributes" do
      expect(company).to be_a(TornRuby::Company)
        .and have_attributes(
          name: "Slippery When Wet",
          director: 3_391_134,
          employees_hired: 10,
          daily_income: 1_322_838
        )
    end

    it "has employee data accessible by string ID" do
      employee = company.employees["207875"]
      expect(employee).to include(
        name: "wryte",
        position: "Manager",
        days_in_company: 236,
        last_action: hash_including(
          status: "Offline",
          timestamp: 1_744_802_457,
          relative: "3 days ago"
        ),
        status: hash_including(
          description: "Okay",
          state: "Okay",
          color: "green"
        )
      )
    end
  end

  describe "#market" do
    subject(:market) { client.market }

    let(:mock_response) do
      {
        "ID" => 96_842,
        "company_type" => 26,
        "rating" => 8,
        "name" => "Slippery When Wet",
        "director" => 3_391_134,
        "employees_hired" => 10,
        "employees_capacity" => 10,
        "daily_income" => 1_322_838,
        "daily_customers" => 24_009,
        "weekly_income" => 13_071_476,
        "weekly_customers" => 239_180,
        "days_old" => 950
      }
    end

    before do
      market_endpoint = instance_double(TornRuby::Endpoints::Market)
      allow(TornRuby::Endpoints::Market).to receive(:new).and_return(market_endpoint)
      allow(market_endpoint).to receive(:fetch).and_return(mock_response)
    end

    it "returns a TornRuby::Company with expected attributes" do
      expect(market).to be_a(TornRuby::Company)
        .and have_attributes(
          name: "Slippery When Wet",
          director: 3_391_134,
          employees_hired: 10,
          daily_income: 1_322_838
        )
    end
  end

  describe "#torn" do
    subject(:torn) { client.torn }

    let(:mock_response) do
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
          }
        ]
      }
    end

    before do
      torn_endpoint = instance_double(TornRuby::Endpoints::Torn)
      allow(TornRuby::Endpoints::Torn).to receive(:new).and_return(torn_endpoint)
      allow(torn_endpoint).to receive(:fetch).and_return(mock_response)
    end

    it "returns a TornRuby::Torn with expected attributes" do
      expect(torn).to be_a(TornRuby::Torn)
        .and have_attributes(
          bounties: match_array(
            hash_including(
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
            )
          )
        )
    end
  end

  describe "#racing" do
    subject(:racing) { client.racing }

    let(:mock_response) do
      {
        "cars": [
          {
            "car_item_id": 77,
            "car_item_name": "Tabata RM2",
            "top_speed": 25,
            "acceleration": 20,
            "braking": 15,
            "dirt": 15,
            "handling": 20,
            "safety": 20,
            "tarmac": 20,
            "class": "D"
          },
        ]
      }
    end

    before do
      racing_endpoint = instance_double(TornRuby::Endpoints::Racing)
      allow(TornRuby::Endpoints::Racing).to receive(:new).and_return(racing_endpoint)
      allow(racing_endpoint).to receive(:fetch).and_return(mock_response)
    end

    it "returns a TornRuby::Racing with expected attributes" do
      expect(racing).to be_a(TornRuby::Racing)
        .and have_attributes(
          cars: match_array(
            hash_including(
              car_item_id: 77,
              car_item_name: "Tabata RM2",
              top_speed: 25,
              acceleration: 20,
              braking: 15,
              dirt: 15,
              handling: 20,
              safety: 20,
              tarmac: 20,
              class: "D"
            )
          )
        )
    end
  end
end
