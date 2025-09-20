class Family < ApplicationRecord
  include Hashid::Rails

  has_many :players
  has_many :games, through: :players
end
