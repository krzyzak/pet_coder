# frozen_string_literal: true

FactoryBot.define do
  factory :level do
    pet { { x: 0, y: 0 } }
    target { { x: 1, y: 1 } }
    walls { [] }
    treats { [] }
    holes { [] }
    gates { [] }
  end
end
