# frozen_string_literal: true

class PlayersController < ApplicationController
  before_action :find_player, only: [:edit, :update, :change]

  def new
    @player = Current.family.players.build
  end

  def edit
  end

  def create
    @player = Current.family.players.build(player_params)

    if @player.save
      cookies[:player_id] = @player.hashid

      redirect_to root_path(Current.family.hashid)
    else
      render :new, status: :unprocessable_content
    end
  end

  def change
    cookies[:player_id] = @player.hashid

    redirect_to root_path(Current.family.hashid)
  end

  def leaderboard
    @players = Current.family.players.leaderboard
  end

  def update
    if @player.update(player_params)
      redirect_to leaderboard_players_path(Current.family)
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def find_player
    @player = Current.family.players.find(params[:id])
  end

  def player_params
    params.expect(player: [:name, :pet_id, :treat_id, :target_id])
  end
end
