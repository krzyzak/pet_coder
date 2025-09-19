# frozen_string_literal: true

class Level < ApplicationRecord
  attribute :pet, :point
  attribute :target, :point

  def treats
    super.map { TreatObject.new(position: PointType.new.cast(it)) }
  end

  def walls
    super.map { WallObject.new(position: PointType.new.cast(it)) }
  end

  def holes
    super.map { HoleObject.new(position: PointType.new.cast(it)) }
  end
end
