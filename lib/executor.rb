# frozen_string_literal: true

class Executor
  delegate :pet, to: :game

  attr_reader :game

  def initialize(game:)
    @game = game
  end

  def execute(command)
    case command
    when :left
      pet.move_left(game.walls)
    when :right
      pet.move_right(game.walls)
    when :up
      pet.move_up(game.walls)
    when :down
      pet.move_down(game.walls)
    end
  end
end
