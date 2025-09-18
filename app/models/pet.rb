# frozen_string_literal: true

class Pet < ApplicationRecord
  include Cycleable, Movable

  attribute :position, PointType.new, default: -> { Current.level.pet }

  after_commit :update_pet

  private

  def update_pet
    broadcast_replace_later partial: "pets/pet", locals: position.to_h, target: :pet
  end
end
