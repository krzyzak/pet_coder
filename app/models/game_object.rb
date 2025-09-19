# frozen_string_literal: true

class GameObject
  attr_accessor :position

  def initialize(position:)
    @position = position
  end

  def kind
    self.class.name.gsub("Object", "").underscore
  end

  def to_key
    [position.x, position.y]
  end
end
