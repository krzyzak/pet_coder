class Target < ApplicationRecord
  include Cycleable

  attribute :position, PointType.new, default: -> { Level.first.target }
end
