# frozen_string_literal: true

class Game < ApplicationRecord
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

  delegate :walls, to: :level

  def treats
    @treats ||= level.treats.map do |position|
      treat.dup.tap do |treat|
        treat.position = position
      end
    end
  end

  def after_move_checks!
    consume_treat!
  end

  def after_commands_check!
    if pet.position == target.position
      level_up!
    else
      restart_level!
    end
  end

  def reset!
    update(points: 0, lives: LIVES, level_id: 1)
  end

  private

  def level_up!
    update(level_id: level_id + 1, points: points + POINTS_PER_LEVEL)
  end

  def restart_level!
    update(lives: lives - 1)
  end

  def set_defaults
    self.level ||= Level.first
    self.lives ||= LIVES
  end

  def consume_treat!
    treat = treats.find { it.position == pet.position }
    return unless treat

    update(points: points + treat.points)
  end
end
