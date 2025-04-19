# frozen_string_literal: true

require "spec_helper"
require "json"
require "net/http"

RSpec.describe TornRuby::Endpoints::Company do
  subject(:company_endpoint) { described_class.new(api_key) }

  let(:api_key) { "test_key" }

  describe "#valid_fields?" do
    it "returns true for all valid fields" do
      expect(company_endpoint.valid_fields?(%w[companies news stock])).to be true
    end

    it "returns false if any invalid field is present" do
      expect(company_endpoint.valid_fields?(%w[companies invalid_field])).to be false
    end
  end
end
