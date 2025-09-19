# frozen_string_literal: true

class Executor
  delegate :pet, to: :game

  attr_reader :game

  def initialize(game:)
    @game = game
    @actions = []
    @index = 0
    @position = game.level.pet.dup
  end

  def execute(commands)
    bonus_points = 0

    commands.each do |command|
      calculate_new_position(command)

      next unless move_allowed?

      case item = game.at_position(@new_position)
      when WallObject
        next
      when TreatObject
        bonus_points += game.treat.points
        perform(:delayed_remove, { target: item }, increase_index: false)
        perform(:increase_points, { amount: game.treat.points }, increase_index: false)
        move_pet
      else
        move_pet
      end
    end

    game.check!(@position, bonus_points: bonus_points)

    @index += 1
    perform(:turbo_redirect, { url: "/" })

    @actions
  end

  private

  def move_pet
    @position = @new_position
    perform(:move_pet, { x: @new_position.x, y: @new_position.y })
  end

  def perform(action, params, increase_index: true)
    @actions << [action, params.merge(index: @index)]
    @index += 1 if increase_index
  end

  def calculate_new_position(command)
    @new_position = @position.dup

    case command
    when :left
      @new_position.x -= 1
    when :right
      @new_position.x += 1
    when :up
      @new_position.y -= 1
    when :down
      @new_position.y += 1
    end
  end

  def move_allowed?
    return false if (0..Game::GRID_SIZE).exclude?(@new_position.x)
    return false if (0..Game::GRID_SIZE).exclude?(@new_position.y)

    true
  end
end
