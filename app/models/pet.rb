class Pet < ApplicationRecord
  attribute :position, :point, default: -> { Level.first.pet }
end
