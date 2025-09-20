# frozen_string_literal: true

class PlayersController < ApplicationController
  def new
    @player = Current.family.players.build
  end

  def create
    @player = Current.family.players.build(player_params)

    if @player.save
      cookies[:player_id] = @player.hashid

      redirect_to root_path(Current.family.hashid)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def change
    player = Current.family.players.find(params[:id])
    cookies[:player_id] = player.hashid

    redirect_to root_path(Current.family.hashid)
  end

  private

  def player_params
    params.expect(player: [:name, :pet_id, :treat_id, :target_id])
  end
end
