# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :set_family

  def set_family
    if cookies[:family_id]
      Current.family = Family.find(cookies[:family_id])
    else
      family = params[:family_id] ? Family.find(params[:family_id]) : Family.create

      cookies[:family_id] = family.hashid
      redirect_to new_player_path(family_id: family.hashid)
    end
  end
end
