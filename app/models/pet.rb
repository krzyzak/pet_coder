class Pet < ApplicationRecord
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

  def update_pet
    broadcast_replace_later partial: "pets/pet", locals: position.to_h
  end
end
