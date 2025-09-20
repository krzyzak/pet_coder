# frozen_string_literal: true

class Player < ApplicationRecord
  include Hashid::Rails

  belongs_to :family
  belongs_to :pet
  belongs_to :treat
  belongs_to :target

  has_many :games, dependent: :destroy

  after_create :create_game!

  validates :name, presence: true

  scope :leaderboard, -> { select("players.*, (SELECT MAX(points) FROM games WHERE games.player_id = players.id) AS max_score, (SELECT COUNT(*) FROM games WHERE games.player_id = players.id) AS games_count").order(max_score: :desc, games_count: :desc) }

  def create_game!
    Game.create!(
      player: self,
      pet: pet,
      treat: treat,
      target: target,
    )
  end

  def display_rules!
    update(read_game_rules: true) && read_game_rules_previously_changed?
  end
end
