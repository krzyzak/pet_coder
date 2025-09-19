# frozen_string_literal: true

FactoryBot.define do
  factory :target do
    sequence(:name) { |n| "#{Faker::Commerce.product_name} #{n}" }
    image_name { "#{name.downcase.tr(" ", "_")}.png" }
  end
end
