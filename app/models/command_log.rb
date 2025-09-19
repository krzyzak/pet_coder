# frozen_string_literal: true

class CommandLog < ApplicationRecord
  belongs_to :game
  belongs_to :level

  def parsed_output
    @parsed_output ||= JSON.parse(output)
  end
end
