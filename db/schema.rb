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

ActiveRecord::Schema.define(version: 20150205071207) do

  create_table "addresses", force: :cascade do |t|
    t.string   "street"
    t.string   "city"
    t.integer  "state"
    t.string   "zip"
    t.integer  "building_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "adults", force: :cascade do |t|
    t.string   "first"
    t.string   "last"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "buildings", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "children", force: :cascade do |t|
    t.string   "first"
    t.string   "last"
    t.date     "birth_date"
    t.integer  "adult_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "children", ["adult_id"], name: "index_children_on_adult_id"

  create_table "courses", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "subject_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "workshop"
  end

  add_index "courses", ["subject_id"], name: "index_courses_on_subject_id"
  add_index "courses", ["title"], name: "index_courses_on_title", unique: true

  create_table "enrollments", force: :cascade do |t|
    t.integer  "enrollable_id"
    t.string   "enrollable_type"
    t.integer  "section_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "paid",            default: false
  end

  add_index "enrollments", ["enrollable_type", "enrollable_id"], name: "index_enrollments_on_enrollable_type_and_enrollable_id"
  add_index "enrollments", ["section_id"], name: "index_enrollments_on_section_id"

  create_table "meeting_day_times", force: :cascade do |t|
    t.integer  "day"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "section_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "meeting_day_times", ["section_id"], name: "index_meeting_day_times_on_section_id"

  create_table "rooms", force: :cascade do |t|
    t.string   "name"
    t.integer  "building_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "rooms", ["name"], name: "index_rooms_on_name", unique: true

  create_table "sections", force: :cascade do |t|
    t.decimal  "fee"
    t.integer  "session_id"
    t.integer  "room_id"
    t.integer  "adult_id"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sections", ["adult_id"], name: "index_sections_on_adult_id"
  add_index "sections", ["course_id"], name: "index_sections_on_course_id"
  add_index "sections", ["room_id"], name: "index_sections_on_room_id"
  add_index "sections", ["session_id"], name: "index_sections_on_session_id"

  create_table "sessions", force: :cascade do |t|
    t.integer  "term"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "workshop"
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.string   "abbrev"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subjects", ["abbrev"], name: "index_subjects_on_abbrev", unique: true
  add_index "subjects", ["name"], name: "index_subjects_on_name", unique: true

end
