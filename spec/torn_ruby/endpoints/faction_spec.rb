# frozen_string_literal: true

require "spec_helper"
require "torn_ruby/endpoints/faction"

RSpec.describe TornRuby::Endpoints::Faction do
  subject(:faction_endpoint) { described_class.new(api_key) }

  let(:api_key) { "test_api_key" }

  describe "#valid_fields?" do
    context "when all fields are valid" do
      let(:fields) { %w[basic crimes] }

      it "returns true" do
        expect(faction_endpoint.valid_fields?(fields)).to be(true)
      end
    end

    context "when one field is invalid" do
      let(:fields) { %w[basic invalid_field bars] }

      it "returns false" do
        expect(faction_endpoint.valid_fields?(fields)).to be(false)
      end
    end

    context "when no fields are passed" do
      let(:fields) { [] }

      it "returns true" do
        expect(faction_endpoint.valid_fields?(fields)).to be(true)
      end
    end
  end
end
