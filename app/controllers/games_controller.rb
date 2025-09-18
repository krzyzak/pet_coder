class GamesController < ApplicationController
  def show
    Current.player = Player.first
    Current.game = Game.first
  end

  def execute
    Current.game = Game.first
    parser = Parser.new
    parser.parse(params[:code])

    GameExecutionJob.perform_now(Current.game, parser.commands, Current.pet.position)
  end
end
