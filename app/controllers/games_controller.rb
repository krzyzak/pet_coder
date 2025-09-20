# frozen_string_literal: true

class GamesController < ApplicationController
  before_action :set_player
  before_action :set_game

  def show
  end

  def reset
    Current.game.reset!

    render turbo_stream: turbo_stream.turbo_redirect(url: root_path)
  end

  def execute
    parser = Parser.new
    executor = Executor.new(game: Current.game)
    result = parser.parse(params[:code])

    if result.success?
      @turbo_actions = executor.execute(result.data[:commands])
      # TODO: add error handling
    end
  end

  def change_pet
    next_pet = Pet.next_for(Current.pet)
    Current.game.update!(pet: next_pet)

    render turbo_stream: turbo_stream.replace(:pet_image, partial: "pets/pet_image", locals: { pet: next_pet })
  end

  def change_treat
    next_treat = Treat.next_for(Current.game.treat)
    Current.game.update!(treat: next_treat)

    render turbo_stream: turbo_stream.replace(:treat_image, partial: "treats/treat_image", locals: { treat: next_treat, level: Current.level })
  end

  def change_target
    next_target = Target.next_for(Current.target)
    Current.game.update!(target: next_target)

    render turbo_stream: turbo_stream.replace(:target_image, partial: "targets/target_image", locals: { target: next_target })
  end

  private

  def set_player
    redirect_to new_player_path(family_id: Current.family) unless cookies[:player_id]

    Current.player = Current.family.players.find(cookies[:player_id])
  end

  def set_game
    Current.game = Current.player.games.last
  end
end
