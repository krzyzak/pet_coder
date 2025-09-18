# frozen_string_literal: true

class Target < ApplicationRecord
  include Cycleable

  attribute :position, PointType.new, default: -> { Current.level.target }
end
