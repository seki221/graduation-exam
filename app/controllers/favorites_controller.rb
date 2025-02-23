# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :set_schedule, only: %i[create destroy]
  before_action :authenticate_user! # ログイン中のユーザーのみに許可（未ログインなら、ログイン画面へ移動）

  # お気に入り表示
  def index
    @favorites = current_user.favorites.includes(:schedule)
  end

  # お気に入り登録
  def create
    return unless @schedule.user_id == current_user.id

    @favorite = Favorite.create(user_id: current_user.id, schedule_id: @schedule.id)
  end

  # お気に入り削除
  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, schedule_id: @schedule.id)
    @favorite.destroy
  end

  private

  def set_schedule
    @schedule = Schedule.find(params[:schedule_id])
  end
end
