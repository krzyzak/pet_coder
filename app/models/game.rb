# frozen_string_literal: true

class Game < ApplicationRecord
  LIVES = 3
  GRID_SIZE = 10

  belongs_to :player
  belongs_to :pet
  belongs_to :treat
  belongs_to :target
  belongs_to :level

  before_validation :set_defaults

  delegate :walls, to: :level

  def set_defaults
    self.level ||= Level.first
    self.lives ||= LIVES
  end
end
