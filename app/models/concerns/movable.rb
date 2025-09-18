# frozen_string_literal: true

module Movable
  extend ActiveSupport::Concern

  def move_up(walls)
    new_position.y -= 1

    update(position: new_position) if move_allowed?(new_position, walls)
  end

  def move_down(walls)
    new_position.y += 1

    update(position: new_position) if move_allowed?(new_position, walls)
  end

  def move_left(walls)
    new_position.x -= 1

    update(position: new_position) if move_allowed?(new_position, walls)
  end

  def move_right(walls)
    new_position.x += 1

    update(position: new_position) if move_allowed?(new_position, walls)
  end

  private

  def new_position
    @new_position ||= position.dup
  end

  def move_allowed?(new_position, walls)
    return false if (0..Game::GRID_SIZE).exclude?(new_position.x)
    return false if (0..Game::GRID_SIZE).exclude?(new_position.y)
    return false if walls.any? { it == new_position }

    true
  end
end
