# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :timeoutable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  validates :nickname, presence: true, length: { minimum: 2 }, unless: :omniauth_provider?

  has_many :schedules, dependent: :destroy
  has_many :planners, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_schedules, through: :favorites, source: :schedule

  enum role: { general: 0, admin: 1 }

  def own?(schedule)
    id == schedule.user_id
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[user]
  end

  # お気に入り
  def favorite?(schedule)
    favorite_schedules.exists?(schedule_id: schedule.id)
  end

  # def favorite(schedule)
  #   favorite_schedules << schedule
  # end

  def favorite(schedule)
    favorites.create(user_id: id, schedule_id: schedule.id) unless favorite?(schedule)
  end

  # def unfavorite(schedule)
  #   favorite_schedules.destroy(schedule)
  # end

  def unfavorite(schedule)
    favorites.find_by(schedule_id: schedule.id)&.destroy
  end

  # by guest_user
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲスト'
      user.name_kana = 'げすと'
      user.country_code = 'JP'
      user.job = 'サラリーマン'
      user.is_deleted = false
      # ＊上記は一例です。
    end
  end

  # by oauth

  def self.from_omniauth(auth)
    user = find_or_initialize_by_provider_and_uid(auth)
    user = merge_with_existing_user(auth, user) if user.new_record?

    update_user_info(user, auth)
    user
  end

  def self.find_or_initialize_by_provider_and_uid(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize
  end

  def self.merge_with_existing_user(auth, user)
    if (existing_user = find_by(email: auth.info.email))
      existing_user.update(provider: auth.provider, uid: auth.uid)
      return existing_user
    end
    user
  end

  def self.update_user_info(user, auth)
    user.email ||= auth.info.email
    user.password ||= Devise.friendly_token[0, 20]
    user.nickname ||= auth.info.name || "User#{SecureRandom.hex(4)}"
    # user.skip_confirmation!
    user.confirmed_at ||= Time.current
    user.save!
  end

  # def self.new_with_session(params, session)
  #   provider = "google"
  #   super.tap do |user|
  #     if data = session["devise.#{ provider }_data"] && session["devise.#{ provider }_data"]["extra"]["raw_info"]
  #       user.email = data["email"] if user.email.blank?
  #     end
  #   end
  # end

  def self.new_with_session(params, session)
    provider = 'google'
    super.tap do |user|
      if (session_data = session["devise.#{provider}_data"]) && (raw_info = session_data['extra']&.dig('raw_info')) && user.email.blank?
        user.email = raw_info['email']
      end
    end
  end

  def omniauth_provider?
    provider.present?
  end

  # URL の :id の部分に id 以外を指定
  def to_param
    screen_name
  end

  private ###################################################################

  # 新規会員登録時および更新時にuser_idに重複が無いかをチェックした上で保存する
  def check_secure_id
    # return if User.find_by(user_uid: user_uid) != nil
    return if User.find_by(user_uid: user_uid)

    # 初回設定時
    loop do
      break if User.find_by(user_uid: user_uid).nil?

      self.user_uid = SecureRandom.alphanumeric(20)
    end
  end

  # 新規会員登録時および更新時にscreen_idに重複が無いかをチェックした上で保存する
  def check_screen_id
    # return if User.find_by(screen_name: screen_name) != nil
    return if User.find_by(screen_name: screen_name)

    loop do
      break if User.find_by(screen_name: screen_name).nil?

      self.screen_name = SecureRandom.alphanumeric
    end
  end
end
