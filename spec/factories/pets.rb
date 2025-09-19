# frozen_string_literal: true

FactoryBot.define do
  factory :pet do
    sequence(:name) { |n| "#{Faker::Creature::Animal.name} #{n}" }
    image_name { "#{name.downcase.tr(" ", "_")}.png" }
  end
end
