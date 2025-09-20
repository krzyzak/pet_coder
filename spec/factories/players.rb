# frozen_string_literal: true

FactoryBot.define do
  factory :player do
    family
    name { Faker::Name.first_name }
    pet
    treat
    target
  end
end
