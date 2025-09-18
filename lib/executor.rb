class Executor
  delegate :pet, to: :game
  attr_reader :game

  def initialize(game:)
    @game = game
  end

  def execute(command)
    case command
    when :left
      pet.move_left
    when :right
      pet.move_right
    when :up
      pet.move_up
    when :down
      pet.move_down
    end
  end
end
