# frozen_string_literal: true

require "spec_helper"
require "torn_ruby/endpoints/user"

RSpec.describe TornRuby::Endpoints::Property do
  let(:api_key) { "test_api_key" }
  let(:property_endpoint) { described_class.new(api_key) }

  describe "#valid_fields?" do
    context "when fields are valid" do
      let(:valid_fields) { ["property"] }

      it "returns true" do
        expect(property_endpoint.valid_fields?(valid_fields)).to be(true)
      end
    end

    context "when fields are invalid" do
      let(:invalid_fields) { ["invalid_field"] }

      it "returns false" do
        expect(property_endpoint.valid_fields?(invalid_fields)).to be(false)
      end
    end
  end
end
