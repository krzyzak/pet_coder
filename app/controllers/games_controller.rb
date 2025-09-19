# frozen_string_literal: true

class GamesController < ApplicationController
  before_action :set_game

  def show
  end

  def execute
    parser = Parser.new
    parser.parse(params[:code])

    executor = Executor.new(game: Current.game)
    @turbo_actions = executor.execute(parser.commands)
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

    render turbo_stream: turbo_stream.replace(:target, partial: "targets/target", locals: { target: Current.target })
  end

  private

  def set_game
    Current.game = Game.first
  end
end
