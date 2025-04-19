# frozen_string_literal: true

require "spec_helper"

RSpec.describe TornRuby::Company do
  subject(:company) { described_class.new(data) }

  let(:data) do
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

  it "initializes with the expected top-level attributes" do
    expect(company).to have_attributes(
      ID: 96_842,
      company_type: 26,
      rating: 8,
      name: "Slippery When Wet",
      director: 3_391_134,
      employees_hired: 10,
      employees_capacity: 10,
      daily_income: 1_322_838,
      daily_customers: 24_009,
      weekly_income: 13_071_476,
      weekly_customers: 239_180,
      days_old: 950
    )
  end

  it "contains nested employee data" do
    expect(company.employees["207875"]).to include(
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
        color: "green"
      )
    )
  end

  it "does not define methods for missing fields" do
    expect(company).not_to respond_to(:nonexistent_field)
  end
end
