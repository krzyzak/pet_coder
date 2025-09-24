# frozen_string_literal: true

require "rails_helper"

RSpec.describe GateObject do
  subject(:gate) { described_class.new(position: Point.new(x: 1, y: 1)) }

  describe "initialization" do
    it "starts in closed state by default" do
      expect(gate.closed?).to be true
      expect(gate.opened?).to be false
    end

    it "has a position" do
      expect(gate.position).to eq(Point.new(x: 1, y: 1))
    end
  end

  describe "#opened?" do
    context "when gate is closed" do
      it "returns false" do
        expect(gate.opened?).to be false
      end
    end

    context "when gate is opened" do
      before { gate.open! }

      it "returns true" do
        expect(gate.opened?).to be true
      end
    end
  end

  describe "#closed?" do
    context "when gate is closed" do
      it "returns true" do
        expect(gate.closed?).to be true
      end
    end

    context "when gate is opened" do
      before { gate.open! }

      it "returns false" do
        expect(gate.closed?).to be false
      end
    end
  end

  describe "#image_name" do
    context "when gate is closed" do
      it "returns gate_closed" do
        expect(gate.image_name).to eq("gate_closed")
      end
    end

    context "when gate is opened" do
      before { gate.open! }

      it "returns gate_opened" do
        expect(gate.image_name).to eq("gate_opened")
      end
    end
  end
end
