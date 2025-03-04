# frozen_string_literal: true

class Schedule < ApplicationRecord
  belongs_to :user
  belongs_to :planner
  has_many :reviews, dependent: :destroy
  has_many :schedule_transportations, dependent: :destroy
  has_many :transportations, through: :schedule_transportations
  has_many :favorite_users, through: :favorites, source: :user
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date

  def self.ransackable_associations(_auth_object = nil)
    %w[user]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[destination start_at end_at cost review transportations]
  end

  def end_date_after_start_date
    return if start_date.blank? || end_date.blank?

    return unless end_date < start_date

    errors.add(:end_date, 'は開始日時より後に設定してください。')
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user)
  end
end
