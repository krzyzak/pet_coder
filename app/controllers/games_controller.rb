# frozen_string_literal: true

class GamesController < ApplicationController
  before_action :set_game

  def show
  end

  def execute
    parser = Parser.new
    parser.parse(params[:code])

    GameExecutionJob.perform_now(Current.game, parser.commands, Current.pet.position)
  end

  def change_pet
    next_pet = Pet.next_for(Current.pet)
    Current.game.update!(pet: next_pet)

    render turbo_stream: turbo_stream.replace(:pet, partial: "pets/pet", locals: { pet: Current.pet, **Current.pet.position.to_h })
  end

  def change_treat
    next_treat = Treat.next_for(Current.game.treat)
    Current.game.update!(treat: next_treat)
  end

  def change_target
    next_target = Target.next_for(Current.target)
    Current.game.update!(target: next_target)

    render turbo_stream: turbo_stream.replace(:target, partial: "targets/target", locals: { target: Current.target })
  end

  private

  def set_game
    Current.game = Game.first
  end
end
