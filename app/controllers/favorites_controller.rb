# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :set_schedule, only: %i[create destroy]
  before_action :authenticate_user! # ログイン中のユーザーのみに許可（未ログインなら、ログイン画面へ移動）

  # お気に入り表示
  def index
    @favorites = current_user.favorite_schedules.includes(:user).order(created_at: :desc)
  end

  def create
    @schedule = Schedule.find(params[:schedule_id])
    # scheduleモデルからschedule_idを探してくる。
    current_user.favorite(@schedule)
    # ログイン中のユーザーと紐づけられたidを取ってくる。この時、user.rbに定義したaliasを使用し、idの情報を保存する。
    respond_to do |format|
      format.js # create.js.erb をレンダリング
      format.html { redirect_to request.referer, notice: 'ブックマークしました' } # rubocop:disable Rails/I18nLocaleTexts
    end
  end

  # お気に入り削除
  def destroy
    @schedule = Schedule.find(params[:schedule_id])
    current_user.unfavorite(@schedule)
    respond_to do |format|
      format.js # destroy.js.erb をレンダリング
      format.html { redirect_to request.referer, notice: 'ブックマークを解除しました' } # rubocop:disable Rails/I18nLocaleTexts
    end
  end

  private

  def set_schedule
    @schedule = Schedule.find(params[:schedule_id])
  end
end
