# frozen_string_literal: true

module Cycleable
  extend ActiveSupport::Concern

  class_methods do
    def next_for(current_record)
      return first if current_record.nil?

      where("id > ?", current_record.id).first || first
    end
  end
end
