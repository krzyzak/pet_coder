# frozen_string_literal: true

class Level < ApplicationRecord
  attribute :pet, :point
  attribute :target, :point

  def treats
    super.map { PointType.new.cast(it) }
  end

  def walls
    super.map { PointType.new.cast(it) }
  end
end
