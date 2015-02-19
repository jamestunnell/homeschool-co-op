# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150219202240) do

  create_table "addresses", force: :cascade do |t|
    t.string   "street"
    t.string   "city"
    t.integer  "state"
    t.string   "zip"
    t.integer  "building_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "buildings", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "workshop"
    t.integer  "subject_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "courses", ["name"], name: "index_courses_on_name", unique: true
  add_index "courses", ["subject_id"], name: "index_courses_on_subject_id"

  create_table "enrollments", force: :cascade do |t|
    t.boolean  "paid"
    t.integer  "student_id"
    t.integer  "section_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "enrollments", ["section_id"], name: "index_enrollments_on_section_id"
  add_index "enrollments", ["student_id"], name: "index_enrollments_on_student_id"

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "photo"
    t.integer  "building_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "meeting_day_times", force: :cascade do |t|
    t.integer  "day"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "section_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "meeting_day_times", ["section_id"], name: "index_meeting_day_times_on_section_id"

  create_table "responsibilities", force: :cascade do |t|
    t.integer  "kind"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "responsibilities", ["user_id"], name: "index_responsibilities_on_user_id"

  create_table "rooms", force: :cascade do |t|
    t.string   "name"
    t.integer  "building_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "rooms", ["building_id"], name: "index_rooms_on_building_id"

  create_table "sections", force: :cascade do |t|
    t.decimal  "fee"
    t.integer  "term_id"
    t.integer  "room_id"
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sections", ["course_id"], name: "index_sections_on_course_id"
  add_index "sections", ["room_id"], name: "index_sections_on_room_id"
  add_index "sections", ["term_id"], name: "index_sections_on_term_id"
  add_index "sections", ["user_id"], name: "index_sections_on_user_id"

  create_table "students", force: :cascade do |t|
    t.string   "first"
    t.string   "last"
    t.date     "birth_date"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "medical"
  end

  add_index "students", ["user_id"], name: "index_students_on_user_id"

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.string   "abbrev"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subjects", ["abbrev"], name: "index_subjects_on_abbrev", unique: true
  add_index "subjects", ["name"], name: "index_subjects_on_name", unique: true

  create_table "terms", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "workshop"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first"
    t.string   "last"
    t.string   "avatar"
    t.text     "bio"
    t.string   "phone"
    t.string   "emergency_name"
    t.string   "emergency_phone"
    t.boolean  "parent_agreement"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
