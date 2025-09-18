# frozen_string_literal: true

class Treat < ApplicationRecord
  include Cycleable

  attribute :position, :point
end
