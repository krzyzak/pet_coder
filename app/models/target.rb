class Target < ApplicationRecord
  attribute :position, :point, default: -> { Level.first.target }
end
