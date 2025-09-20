# frozen_string_literal: true

class Family < ApplicationRecord
  include Hashid::Rails

  has_many :players, dependent: :destroy
  has_many :games, through: :players
end
