# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  attribute :game, :family, :player

  delegate :pet, :target, :level, to: :game
end
