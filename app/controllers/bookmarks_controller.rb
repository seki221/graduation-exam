# frozen_string_literal: true

class BookmarksController < ApplicationController
  before_action :set_schedule, only: %i[index destroy]
  # before_action :require_login

  def index
    @bookmark = current_user.bookmarks.build(schedule_id: params[:schedule_id])
    @bookmark.save
    redirect_to planner_schedules_path(planner)
  end

  def create
    @schedule = Schedule.find(params[:schedule_id])
    @bookmark = @schedule.bookmarks.build(bookmark_params)
    @bookmark.user = current_user

    # @bookmark = current_user.bookmarks.build(bookmark_params)
    if @bookmark.save
      redirect_to planner_schedules_path(@bookmark.schedule), success: t('defaults.flash_message.created')
    else
      redirect_to planner_schedules_path(@bookmark.schedule), danger: t('defaults.flash_message.not_created')
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
