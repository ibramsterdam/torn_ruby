# frozen_string_literal: true

require "spec_helper"

RSpec.describe TornRuby::User do
  let(:data) do
    {
      "rank" => "Star Trader",
      "level" => 37,
      "name" => "Bram",
      "life" => { "current" => 1725, "maximum" => 1725 }
    }
  end

  subject(:user) { described_class.new(data) }

  it do
    is_expected.to have_attributes(
      rank: "Star Trader",
      level: 37,
      name: "Bram",
      life: hash_including(
        current: 1725,
        maximum: 1725
      )
    )
  end

  it "does not define methods for missing keys" do
    expect(user).not_to respond_to(:nonexistent_key)
  end
end
