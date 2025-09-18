# frozen_string_literal: true

class Pet < ApplicationRecord
  include Cycleable

  attribute :position, PointType.new, default: -> { Level.first.pet }

  after_commit :update_pet

  def move_up
    position.y -= 1

    save
  end

  def move_down
    position.y += 1
    save
  end

  def move_left
    position.x -= 1
    save
  end

  def move_right
    position.x += 1
    save
  end

  private

  def update_pet
    broadcast_replace_later partial: "pets/pet", locals: position.to_h, target: :pet
  end
end
