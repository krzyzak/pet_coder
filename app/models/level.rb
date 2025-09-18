# frozen_string_literal: true

class Level < ApplicationRecord
  attribute :pet, PointType.new
  attribute :target, PointType.new

  def treats
    super.map { Point.new.cast(it) }
  end

  def walls
    super.map { Point.new.cast(it) }
  end
end
