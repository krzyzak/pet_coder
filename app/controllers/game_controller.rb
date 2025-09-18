class GameController < ApplicationController
  def show
    Current.player = Player.first
    Current.game = Game.first
  end
end
