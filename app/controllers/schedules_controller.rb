# frozen_string_literal: true

class SchedulesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create index show edit update destroy]
  before_action :move_to_signed_in, except: [:index]
  before_action :set_planner
  # before_action :set_ransack
  def index
    @schedules = Schedule.where(planner_id: @planner.id).order(:start_date)
  end

  def show
    @schedule = Schedule.find(params[:id])
    # @planners = @schedule.planners
    # @schedules_for_date = Schedule.where(date: @schedule.date).order(:start_date)
  end

  def new
    @schedule = Schedule.new
    @planner = Planner.find(params[:planner_id])
    # @planner = Planner.new
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def create
    @schedule = current_user.schedules.build(schedule_params)
    @planner = Planner.find(params[:planner_id])
    @schedule = @planner.schedules.build(schedule_params)
    @schedule.user = current_user

    if @schedule.save
      redirect_to planner_schedules_path(@planner), notice: t('schedules.create')
    else
      render :new
    end
  end

  def update
    @schedule = @planner.schedules.find(params[:id])
    if @schedule.update(schedule_params)
      redirect_to planner_schedule_path(@planner, @schedule), notice: t('schedules.update')
    else
      render :edit
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    flash[:notice_destroy] = t('schedules.destroy')
    redirect_to :date
  end

  def bookmarks
    if params[:schedule_id].present?
      @schedule = Schedule.find(params[:schedule_id])
      @bookmark_schedules = @schedule.bookmarks
    else
      redirect_to root_path, alert: 'スケジュールIDが見つかりません'
    end
  end

  private

  def schedule_params
    params.require(:schedule).permit(:title, :start_date, :end_date, :cost, :transportation, :place, :guaid)
  end

  def find_schedule
    @schedule = current_user.schedules.find(params[:id])
  end

  def set_planner
    @planner = Planner.find(params[:planner_id])
  end

  def authorize_user
    schedule = Schedule.find(params[:id])
    return if current_user.own?(schedule)

    redirect_to schedules_path, alert: t('errors.unauthorized')
  end

  def move_to_signed_in
    return if user_signed_in?

    # サインインしていないユーザーはログインページが表示される
    redirect_to '/users/sign_in'
  end
end
