# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  attribute :level, :game

  delegate :pet, :target, :player, to: :game

  def level
    super || game.level
  end
end
