# frozen_string_literal: true

FactoryBot.define do
  factory :game do
    player
    pet
    treat
    target
    level
    lives { 3 }
    points { 0 }
  end
end
