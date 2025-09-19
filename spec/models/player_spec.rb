# frozen_string_literal: true

require "rails_helper"

RSpec.describe Player do
  subject { build(:player) }

  describe "associations" do
    it { is_expected.to belong_to(:pet) }
    it { is_expected.to belong_to(:treat) }
    it { is_expected.to belong_to(:target) }
    it { is_expected.to have_many(:games).dependent(:destroy) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe "callbacks" do
    let!(:level) { create(:level) }

    it "creates a game after creation" do
      expect do
        create(:player)
      end.to change(Game, :count).by(1)
    end

    it "creates game with correct attributes" do
      player = create(:player)
      game = player.games.first

      expect(game.player).to eq(player)
      expect(game.pet).to eq(player.pet)
      expect(game.treat).to eq(player.treat)
      expect(game.target).to eq(player.target)
    end
  end
end
