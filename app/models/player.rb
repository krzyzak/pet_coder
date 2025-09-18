class Player < ApplicationRecord
  belongs_to :pet
  belongs_to :treat
  belongs_to :target

  after_create :create_game

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
