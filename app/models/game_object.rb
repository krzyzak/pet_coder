# frozen_string_literal: true

class GameObject
  attr_accessor :position, :rotate

  def initialize(position:, rotate: 0)
    @position = position
    @rotate = rotate
  end

  def kind
    self.class.name.gsub("Object", "").underscore
  end

  def model_name
    ActiveModel::Name.new(self.class)
  end

  def image_name
    kind
  end

  def to_key
    [position.x, position.y]
  end
end
