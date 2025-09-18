# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  attribute :player, :game


  delegate :level, :pet, :target, to: :game
end
