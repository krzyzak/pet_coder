class Target < ApplicationRecord
  attribute :position, PointType.new, default: -> { Level.first.target }
end
