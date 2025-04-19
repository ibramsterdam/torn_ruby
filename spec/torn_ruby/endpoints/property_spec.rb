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

  describe "#handle_response" do
    context "when the response is a success" do
      let(:successful_response) do
        instance_double(Net::HTTPSuccess, is_a?: true, code: "200", message: "OK", body: '{"property": "value"}')
      end

      it "parses the response body and returns the property" do
        result = property_endpoint.send(:handle_response, successful_response)
        expect(result).to eq("value")
      end
    end

    context "when the response is not a success" do
      let(:error_response) do
        instance_double(Net::HTTPResponse, is_a?: false, code: "500", message: "Internal Server Error", body: "")
      end

      it "raises a TornRuby::Error with the appropriate message" do
        expect do
          property_endpoint.send(:handle_response, error_response)
        end.to raise_error(TornRuby::Error, "API request failed: 500 Internal Server Error")
      end
    end
  end
end
