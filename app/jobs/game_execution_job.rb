class GameExecutionJob < ApplicationJob
  def perform(game, commands, pet_position)
    command, *rest = commands
    game.pet.position = pet_position
    executor = Executor.new(game: game)

    executor.execute(command)

    puts "Enqueue #{rest}"
    GameExecutionJob.set(wait: 0.3.second).perform_later(game, rest, game.pet.position) unless rest.empty?
  end
end
