# frozen_string_literal: true

require "spec_helper"

RSpec.describe TornRuby::Base do
  describe "#initialize" do
    subject(:model) { described_class.new(input_data) }

    let(:input_data) do
      {
        "name" => "Bram",
        "level" => 37,
        "life" => {
          "current" => 1725,
          "maximum" => 1725
        }
      }
    end

    let(:symbolized_data) do
      {
        name: "Bram",
        level: 37,
        life: {
          current: 1725,
          maximum: 1725
        }
      }
    end

    before do
      allow(TornRuby::Utils).to receive(:deep_symbolize_keys).with(input_data).and_return(symbolized_data)
    end

    it "symbolizes the keys using TornRuby::Utils.deep_symbolize_keys" do
      model # trigger the call
      expect(TornRuby::Utils).to have_received(:deep_symbolize_keys).with(input_data)
    end

    it "creates accessor methods for each top-level key" do
      expect(model).to have_attributes(
        name: "Bram",
        level: 37,
        life: hash_including(
          current: 1725,
          maximum: 1725
        )
      )
    end

    it "sets instance variables for each key" do
      expect({
               name: model.instance_variable_get("@name"),
               level: model.instance_variable_get("@level"),
               life: model.instance_variable_get("@life")
             }).to eq({
                        name: "Bram",
                        level: 37,
                        life: { current: 1725, maximum: 1725 }
                      })
    end

    it "does not override existing methods" do
      class << model
        def name
          "Overridden"
        end
      end

      expect(model.name).to eq("Overridden")
    end
  end
end
