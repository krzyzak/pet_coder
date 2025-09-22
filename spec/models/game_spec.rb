# frozen_string_literal: true

require "rails_helper"

RSpec.describe Game do
  subject { game }

  let!(:level) { create(:level, target: Point.new(x: 5, y: 5)) }
  let(:player) { create(:player) }
  let(:pet) { create(:pet) }
  let(:treat) { create(:treat) }
  let(:target) { create(:target) }

  let(:game) do
    create(
      :game,
      player: player,
      pet: pet,
      treat: treat,
      target: target,
      level: level,
    )
  end

  describe "associations" do
    it { is_expected.to belong_to(:player) }
    it { is_expected.to belong_to(:pet) }
    it { is_expected.to belong_to(:treat) }
    it { is_expected.to belong_to(:target) }
    it { is_expected.to belong_to(:level).optional }
  end

  describe "validations" do
    it { is_expected.to validate_numericality_of(:lives).is_in(0..Game::LIVES) }
    it { is_expected.to validate_numericality_of(:points).only_integer.is_greater_than_or_equal_to(0) }

    context "when lives is negative" do
      it "is invalid" do
        game.lives = -1
        expect(game).not_to be_valid
        expect(game.errors[:lives]).to include("must be in 0..3")
      end
    end

    context "when points is negative" do
      it "is invalid with negative points" do
        game.points = -10
        expect(game).not_to be_valid
        expect(game.errors[:points]).to include("must be greater than or equal to 0")
      end
    end

    context "when points is zero" do
      it "is valid with zero points" do
        game.points = 0
        expect(game).to be_valid
      end
    end

    context "when points is not an integer" do
      it "is invalid with decimal points" do
        game.points = 10.5
        expect(game).not_to be_valid
        expect(game.errors[:points]).to include("must be an integer")
      end
    end
  end

  describe "#check!" do
    context "when position matches level target" do
      let(:target_position) { Point.new(x: 5, y: 5) }
      let!(:second_level) { create(:level) }

      it "levels up with bonus points" do
        bonus_points = 50

        expect { game.check!(target_position, bonus_points: bonus_points) }.to change { game.reload.level }
          .from(level).to(second_level)
          .and change { game.reload.points }.from(0).to(150) # 50 bonus + 100 per level
      end
    end

    context "when position does not match level target" do
      let(:wrong_position) { Point.new(x: 1, y: 1) }

      it "restarts level and reduces lives" do
        expect { game.check!(wrong_position) }.not_to change { game.reload.level }
        expect { game.check!(wrong_position) }.to change { game.reload.lives }.by(-1)
      end
    end
  end

  describe "#reset!" do
    it "resets game to initial state" do
      game.update(points: 500, lives: 1, level_id: 5, completed: true)

      game.reset!

      expect(game.points).to eq(0)
      expect(game.lives).to eq(Game::LIVES)
      expect(game.level_id).to eq(1)
      expect(game.completed).to be false
    end
  end

  describe "#check! with level completion" do
    context "when there are more levels available" do
      let!(:second_level) { create(:level) }
      let(:target_position) { level.target }

      it "advances to next level and adds points" do
        bonus_points = 50

        expect { game.check!(target_position, bonus_points: bonus_points) }.to change { game.reload.level }
          .from(level).to(second_level)
          .and change { game.reload.points }.from(0).to(150) # 50 bonus + 100 per level
      end
    end

    context "when player has completed all levels" do
      let(:target_position) { level.target }

      it "does not advance level but marks as completed and adds points" do
        max_level_id = Level.maximum(:id)
        game.update(level_id: max_level_id, completed: false)
        initial_points = game.points
        bonus_points = 50

        expect { game.check!(target_position, bonus_points: bonus_points) }.not_to change { game.reload.level }
        
        game.reload
        expect(game.points).to eq(initial_points + 150) # 50 bonus + 100 per level
        expect(game.completed).to be true
      end
    end
  end
end
