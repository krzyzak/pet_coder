# frozen_string_literal: true

module TurboStreams
  module GameHelper
    def move_pet(params)
      turbo_stream_action_tag :move_pet, target: :pet, **params
    end

    def turbo_redirect(params)
      turbo_stream_action_tag :turbo_redirect, **params
    end

    def increase_points(params)
      turbo_stream_action_tag :increase_points, **params
    end

    def delayed_remove(params)
      turbo_stream_action_tag :delayed_remove, **params
    end
  end
end

Turbo::Streams::TagBuilder.prepend(TurboStreams::GameHelper)
