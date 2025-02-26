# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :set_schedule, only: %i[create destroy]
  before_action :authenticate_user! # ログイン中のユーザーのみに許可（未ログインなら、ログイン画面へ移動）

  # お気に入り表示
  def index
    @favorites = current_user.favorites.includes(:schedule)
  end

  # お気に入り登録
  # def create
  #   @favorite = Favorite.find_or_create_by(user_id: current_user.id, schedule_id: @schedule.id)
  #   respond_to do |format|
  #     format.html { redirect_back fallback_location: root_path }
  #     format.json { render json: { status: 'added' } }
  #   end
  # end

  def create
    @favorite = Favorite.find(params[:favorite_id])
    # scheduleモデルからschedule_idを探してくる。
    current_user.favorite(@favorite)
    # ログイン中のユーザーと紐づけられたidを取ってくる。この時、user.rbに定義したaliasを使用し、idの情報を保存する。
  end

  # お気に入り削除
  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, schedule_id: @schedule.id)
    @favorite&.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.json { render json: { status: 'removed' } }
    end
  end

  private

  def set_schedule
    @schedule = Schedule.find(params[:schedule_id])
  end
end
