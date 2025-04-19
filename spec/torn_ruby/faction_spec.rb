# frozen_string_literal: true

require "spec_helper"

RSpec.describe TornRuby::Faction do
  subject(:faction) { described_class.new(data) }

  let(:data) do
    {
      "ID" => 38_761,
      "name" => "Shadow Healers",
      "respect" => 2_450_100,
      "rank" => { "level" => 9, "name" => "Silver", "division" => 3 }
    }
  end

  it do
    expect(faction).to have_attributes(
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

  it "does not define methods for missing keys" do
    expect(faction).not_to respond_to(:nonexistent_key)
  end
end
