# frozen_string_literal: true

module ApplicationHelper
  def asset_exists?(path)
    Rails.application.assets.resolver.resolve(path).present?
  end
end
