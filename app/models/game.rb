# frozen_string_literal: true

class Game < ApplicationRecord
  include Hashid::Rails

  LIVES = 3
  GRID_SIZE = 10
  POINTS_PER_LEVEL = 100

  belongs_to :player
  belongs_to :pet
  belongs_to :treat
  belongs_to :target
  belongs_to :level

  before_validation :set_defaults
  broadcasts_refreshes

  delegate :walls, :treats, :holes, :gates, to: :level

  validates :lives, numericality: { in: 0..LIVES }
  validates :points, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def at_position(position)
    game_objects.find { it.position == position }
  end

  def check!(position, bonus_points: 0)
    if position == level.target
      level_up!(bonus_points)
    else
      restart_level!
    end
  end

  def reset!
    update(points: 0, lives: LIVES, level_id: 1, completed: false)
  end

  def game_over?
    lives.zero?
  end

  def next_level_exists?
    Level.exists?(level_id + 1)
  end

  private

  def game_objects
    @game_objects ||= [*walls, *treats, *holes, *gates]
  end

  def level_up!(bonus_points)
    new_points = points + bonus_points + POINTS_PER_LEVEL

    if next_level_exists?
      update(level_id: level_id + 1, points: new_points)
    else
      update(points: new_points, completed: true)
    end
  end

  def restart_level!
    update(lives: lives - 1)
  end

  def set_defaults
    self.level ||= Level.first
    self.lives ||= LIVES
  end
end
