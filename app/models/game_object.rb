# frozen_string_literal: true

class GameObject
  attr_accessor :position

  def initialize(position:)
    @position = position
  end

  def to_key
    [position.x, position.y]
  end
end
