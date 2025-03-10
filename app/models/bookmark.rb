# frozen_string_literal: true

class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :schedule

  validates :user_id, uniqueness: { scope: :schedule_id }
end
