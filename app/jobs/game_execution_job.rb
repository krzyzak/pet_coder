# frozen_string_literal: true

class GameExecutionJob < ApplicationJob
  def perform(game, commands, pet_position)
    Current.game = game

    command, *rest = commands
    game.pet.position = pet_position
    executor = Executor.new(game: game)

    executor.execute(command)

    game.after_move_checks!

    if rest.empty?
      game.after_commands_check!
    else
      GameExecutionJob.set(wait: 0.3.seconds).perform_later(game, rest, game.pet.position)
    end
  end
end
