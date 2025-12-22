# frozen_string_literal: true

class Executor
  delegate :pet, :gates, to: :game

  attr_reader :game

  def initialize(game:)
    @game = game
    @actions = []
    @index = 0
    @position = game.level.pet.dup
    @bonus_points = 0
  end

  def execute(commands)
    commands.each do |command|
      calculate_new_position(command)
      open_gates if command == :open

      next unless move_allowed?

      case item = game.at_position(@new_position)
      when WallObject
        next
      when HoleObject
        move_pet
        play_sound(:hole)
        break
      when GateObject
        move_pet if item.opened?
      when TreatObject
        @bonus_points += game.treat.points
        perform(:delayed_remove, { target: item }, increase_index: false)
        play_sound(:treat)
        perform(:increase_points, { amount: game.treat.points }, increase_index: false)
        move_pet
      else
        move_pet
      end
    end

    finalize

    @actions
  end

  def finalize
    game.check!(@position, bonus_points: @bonus_points)

    @index += 1

    game.gates.each(&:close!)

    template = ApplicationController.render(game)
    perform(:delayed_replace, { target: :game, template: template })
  end

  private

  def move_pet
    return if @position == @new_position

    @position = @new_position
    perform(:move_pet, { x: @new_position.x, y: @new_position.y })
  end

  def animate_pet_opening
    perform(:animate_pet_opening)
  end

  def open_gates
    animate_pet_opening
    neighbouring_gates.each do |gate|
      gate.open!
      template = ApplicationController.render(gate)

      perform(:delayed_replace, { target: ActionView::RecordIdentifier.dom_id(gate), template: template })
    end
  end

  def perform(action, params = {}, increase_index: true)
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

  def neighbouring_gates
    offsets = [-1, 0, 1]
    neighbours = offsets.product(offsets).map do |dx, dy|
      Point.new(x: @new_position.x + dx, y: @new_position.y + dy)
    end

    gates.select { |gate| neighbours.include?(gate.position) }
  end

  def move_allowed?
    return false if (0...Game::GRID_SIZE).exclude?(@new_position.x)
    return false if (0...Game::GRID_SIZE).exclude?(@new_position.y)

    true
  end

  def play_sound(sound)
    perform(:play_sound, { sound: sound })
  end
end
