# frozen_string_literal: true

require "spec_helper"

RSpec.describe TornRuby::Endpoints::Market do
  let(:api_key) { "your_api_key_here" }
  let(:market) { described_class.new(api_key: api_key) }

  describe "#valid_fields?" do
    context "when all fields are valid" do
      let(:valid_fields) { %w[bazaar itemmarket lookup pointsmarket timestamp] }

      it "returns true" do
        expect(market.valid_fields?(valid_fields)).to be true
      end
    end

    context "when one or more fields are invalid" do
      let(:invalid_fields) { %w[bazaar itemmarket invalid_field] }

      it "returns false" do
        expect(market.valid_fields?(invalid_fields)).to be false
      end
    end

    context "when no fields are provided" do
      it "returns true" do
        expect(market.valid_fields?([])).to be true
      end
    end
  end
end
