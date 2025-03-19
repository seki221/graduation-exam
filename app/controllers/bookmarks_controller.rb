# frozen_string_literal: true

class BookmarksController < ApplicationController
  before_action :set_schedule, only: %i[create destroy]
  # before_action :require_login

  def create
    @schedule = Schedule.find(params[:schedule_id])
    @bookmark = current_user.bookmarks.build(schedule: @schedule)

    if @bookmark.save
      respond_to do |format|
        format.html { redirect_to planner_schedule_path(@schedule.planner, @schedule), notice: 'ブックマークを追加しました。' }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to planner_schedule_path(@schedule.planner, @schedule), alert: 'ブックマークの追加に失敗しました' }
        format.js
      end
    end
  end

  def destroy
    current_user.bookmarks.find_by(schedule_id: params[:schedule_id]).destroy!
    @bookmark.save
  end

  private

  def set_schedule
    @schedule = Schedule.find(params[:schedule_id])
  end
end
