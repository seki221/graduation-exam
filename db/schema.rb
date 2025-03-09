# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2025_03_08_130112) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "schedule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_bookmarks_on_schedule_id"
    t.index ["user_id", "schedule_id"], name: "index_bookmarks_on_user_id_and_schedule_id", unique: true
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "schedule_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_favorites_on_schedule_id"
    t.index ["user_id", "schedule_id"], name: "index_favorites_on_user_id_and_schedule_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "planners", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_date", precision: nil
    t.datetime "end_date", precision: nil
    t.string "title"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_planners_on_user_id"
  end

  create_table "planners_schedules", force: :cascade do |t|
    t.bigint "planner_id", null: false
    t.bigint "schedule_id", null: false
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["planner_id", "schedule_id"], name: "index_planners_schedules_on_planner_id_and_schedule_id", unique: true
  end

  create_table "reviews", force: :cascade do |t|
    t.text "body"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "schedule_id"
    t.index ["schedule_id"], name: "index_reviews_on_schedule_id"
  end

  create_table "schedule_transportations", force: :cascade do |t|
    t.bigint "schedule_id", null: false
    t.bigint "transportation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_schedule_transportations_on_schedule_id"
    t.index ["transportation_id"], name: "index_schedule_transportations_on_transportation_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer "cost"
    t.text "review"
    t.string "transportation"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "image_url"
    t.string "place"
    t.text "guaid"
    t.bigint "planner_id"
    t.datetime "start_date", precision: nil
    t.datetime "end_date", precision: nil
    t.string "title"
    t.date "date"
    t.text "address"
    t.float "latitude"
    t.float "longitude"
    t.index ["planner_id"], name: "index_schedules_on_planner_id"
    t.index ["user_id"], name: "index_schedules_on_user_id"
  end

  create_table "transportations", force: :cascade do |t|
    t.string "category"
    t.bigint "schedule_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_transportations_on_schedule_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nickname"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.integer "role", default: 0, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bookmarks", "schedules"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "favorites", "schedules"
  add_foreign_key "favorites", "users"
  add_foreign_key "planners", "users"
  add_foreign_key "planners_schedules", "planners"
  add_foreign_key "planners_schedules", "schedules"
  add_foreign_key "schedule_transportations", "schedules"
  add_foreign_key "schedule_transportations", "transportations"
  add_foreign_key "schedules", "planners"
  add_foreign_key "schedules", "users"
  add_foreign_key "transportations", "schedules"
end
