# frozen_string_literal: true

require "spec_helper"

RSpec.describe TornRuby::Utils do
  describe ".deep_symbolize_keys" do
    it "symbolizes top-level keys" do
      input = { "foo" => "bar" }
      result = described_class.deep_symbolize_keys(input)
      expect(result).to eq({ foo: "bar" })
    end

    it "recursively symbolizes nested hash keys" do
      input = { "outer" => { "inner" => "value" } }
      result = described_class.deep_symbolize_keys(input)
      expect(result).to eq({ outer: { inner: "value" } })
    end

    it "symbolizes keys in hashes within arrays" do
      input = { "list" => [{ "id" => 1 }, { "id" => 2 }] }

      result = described_class.deep_symbolize_keys(input)
      expect(result).to eq({ list: [{ id: 1 }, { id: 2 }] })
    end

    it "leaves non-hash, non-array values untouched" do
      input = "string"
      result = described_class.deep_symbolize_keys(input)
      expect(result).to eq("string")
    end
  end
end
