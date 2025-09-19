# frozen_string_literal: true

FactoryBot.define do
  factory :treat do
    sequence(:name) { |n| "#{Faker::Food.ingredient} #{n}" }
    image_name { "#{name.downcase.tr(" ", "_")}.png" }
    points { Faker::Number.between(from: 10, to: 100) }
  end
end
