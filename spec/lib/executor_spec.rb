# frozen_string_literal: true

require "rails_helper"

RSpec.describe Executor do
  subject(:executor) { described_class.new(game: game) }

  let!(:level) { create(:level, pet: { x: 2, y: 2 }, target: { x: 5, y: 5 }) }
  let(:game) { create(:game, level: level) }

  describe "#execute" do
    context "with valid move commands" do
      it "executes movement commands and returns actions" do
        actions = executor.execute([:right, :down])

        expect(actions).not_to be_empty
        expect(actions.last).to eq([:turbo_redirect, { url: "/", index: 3 }])
      end

      it "generates move_pet actions for valid moves" do
        allow(game).to receive(:check!)

        actions = executor.execute([:right, :down])

        move_actions = actions.select { |action, _| action == :move_pet }
        expect(move_actions).to contain_exactly(
          [:move_pet, { x: 3, y: 2, index: 0 }],
          [:move_pet, { x: 3, y: 3, index: 1 }],
        )
      end

      it "calls game.check! with final position and bonus points" do
        allow(game).to receive(:check!).with(Point.new(x: 3, y: 3), bonus_points: 0)

        executor.execute([:right, :down])

        expect(game).to have_received(:check!).with(Point.new(x: 3, y: 3), bonus_points: 0)
      end
    end

    context "when hitting boundary" do
      it "doesn't generate move actions for invalid boundary moves" do
        allow(game).to receive(:check!)

        actions = executor.execute([:left, :left, :left, :left])

        move_actions = actions.select { |action, _| action == :move_pet }
        expect(move_actions.length).to eq(2)
        expect(move_actions).to contain_exactly(
          [:move_pet, { x: 1, y: 2, index: 0 }],
          [:move_pet, { x: 0, y: 2, index: 1 }],
        )
      end
    end

    context "when encountering walls" do
      let!(:level_with_wall) do
        create(
          :level,
          pet: { x: 2, y: 2 },
          target: { x: 5, y: 5 },
          walls: [{ x: 3, y: 2 }],
        )
      end
      let(:game_with_wall) { create(:game, level: level_with_wall) }
      let(:executor_with_wall) { described_class.new(game: game_with_wall) }

      it "doesn't generate move actions when blocked by walls" do
        allow(game_with_wall).to receive(:check!)

        actions = executor_with_wall.execute([:right])

        move_actions = actions.select { |action, _| action == :move_pet }
        expect(move_actions).to be_empty
      end
    end

    context "when encountering holes" do
      let!(:level_with_hole) do
        create(
          :level,
          pet: { x: 2, y: 2 },
          target: { x: 5, y: 5 },
          holes: [{ x: 3, y: 2 }],
        )
      end
      let(:game_with_hole) { create(:game, level: level_with_hole) }
      let(:executor_with_hole) { described_class.new(game: game_with_hole) }

      it "stops execution when encountering holes" do
        allow(game_with_hole).to receive(:check!)

        actions = executor_with_hole.execute([:right, :down])

        move_actions = actions.select { |action, _| action == :move_pet }
        expect(move_actions).to contain_exactly(
          [:move_pet, { x: 3, y: 2, index: 0 }],
        )
      end
    end

    context "when encountering treats" do
      let!(:level_with_treat) do
        create(
          :level,
          pet: { x: 2, y: 2 },
          target: { x: 5, y: 5 },
          treats: [{ x: 3, y: 2 }],
        )
      end
      let(:game_with_treat) { create(:game, level: level_with_treat) }
      let(:executor_with_treat) { described_class.new(game: game_with_treat) }

      it "collects treat and adds bonus points" do
        treat_points = game_with_treat.treat.points
        allow(game_with_treat).to receive(:check!).with(anything, bonus_points: treat_points)

        executor_with_treat.execute([:right])

        expect(game_with_treat).to have_received(:check!).with(anything, bonus_points: treat_points)
      end

      it "adds treat collection actions" do
        allow(game_with_treat).to receive(:check!)

        actions = executor_with_treat.execute([:right])

        delayed_remove_action = actions.find { |action, _| action == :delayed_remove }
        increase_points_action = actions.find { |action, _| action == :increase_points }

        expect(delayed_remove_action).not_to be_nil
        expect(increase_points_action).not_to be_nil
        expect(increase_points_action[1][:amount]).to eq(game_with_treat.treat.points)
      end

      it "generates move action to treat position" do
        allow(game_with_treat).to receive(:check!)

        actions = executor_with_treat.execute([:right])

        move_actions = actions.select { |action, _| action == :move_pet }
        expect(move_actions.length).to eq(1)
        expect(move_actions.first[1]).to include(x: 3, y: 2)
      end
    end

    context "with multiple treats" do
      let!(:level_with_treats) do
        create(
          :level,
          pet: { x: 2, y: 2 },
          target: { x: 5, y: 5 },
          treats: [{ x: 3, y: 2 }, { x: 3, y: 3 }],
        )
      end
      let(:game_with_treats) { create(:game, level: level_with_treats) }
      let(:executor_with_treats) { described_class.new(game: game_with_treats) }

      it "accumulates bonus points from multiple treats" do
        treat_points = game_with_treats.treat.points
        expected_bonus = treat_points * 2
        allow(game_with_treats).to receive(:check!).with(anything, bonus_points: expected_bonus)

        executor_with_treats.execute([:right, :down])

        expect(game_with_treats).to have_received(:check!).with(anything, bonus_points: expected_bonus)
      end
    end
  end

  describe "movement direction handling" do
    it "handles all four movement directions correctly" do
      allow(game).to receive(:check!)

      executor_left = described_class.new(game: game)
      executor_right = described_class.new(game: game)
      executor_up = described_class.new(game: game)
      executor_down = described_class.new(game: game)

      actions_left = executor_left.execute([:left])
      actions_right = executor_right.execute([:right])
      actions_up = executor_up.execute([:up])
      actions_down = executor_down.execute([:down])

      move_left = actions_left.find { |action, _| action == :move_pet }
      move_right = actions_right.find { |action, _| action == :move_pet }
      move_up = actions_up.find { |action, _| action == :move_pet }
      move_down = actions_down.find { |action, _| action == :move_pet }

      expect(move_left[1]).to include(x: 1, y: 2)
      expect(move_right[1]).to include(x: 3, y: 2)
      expect(move_up[1]).to include(x: 2, y: 1)
      expect(move_down[1]).to include(x: 2, y: 3)
    end
  end
end
