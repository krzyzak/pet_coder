# frozen_string_literal: true

class Player < ApplicationRecord
  include Hashid::Rails

  belongs_to :pet
  belongs_to :treat
  belongs_to :target

  has_many :games, dependent: :destroy

  after_create :create_game

  validates :name, presence: true

  private

  def create_game
    Game.create!(
      player: self,
      pet: pet,
      treat: treat,
      target: target,
    )
  end
end
