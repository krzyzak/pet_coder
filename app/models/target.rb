# frozen_string_literal: true

class Target < ApplicationRecord
  include Cycleable

  validates :name, presence: true
  validates :image_name, presence: true
end
