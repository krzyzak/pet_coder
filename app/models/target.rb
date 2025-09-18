# frozen_string_literal: true

class Target < ApplicationRecord
  include Cycleable

  attribute :position, :point, default: -> { Current.level.target }
end
