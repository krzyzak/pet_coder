class Game < ApplicationRecord
  LIVES = 3

  belongs_to :player
  belongs_to :pet
  belongs_to :treat
  belongs_to :target
  belongs_to :level

  before_validation :set_defaults

  def set_defaults
    self.level ||= Level.first
    self.lives ||= LIVES
  end
end
