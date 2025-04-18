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
end
