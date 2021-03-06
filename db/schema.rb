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

ActiveRecord::Schema.define(version: 20140901025946) do

  create_table "coordinators", force: true do |t|
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
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coordinators", ["email"], name: "index_coordinators_on_email", unique: true
  add_index "coordinators", ["reset_password_token"], name: "index_coordinators_on_reset_password_token", unique: true

  create_table "courses", force: true do |t|
    t.integer  "program_id"
    t.string   "name"
    t.integer  "semester"
    t.integer  "duration"
    t.integer  "credits"
    t.string   "area"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "holidays", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
  end

  create_table "lecture_days", force: true do |t|
    t.integer  "lecture_id"
    t.date     "date_of_lecture"
    t.time     "time_of_lecture"
    t.integer  "month_of_report"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "report_id"
  end

  add_index "lecture_days", ["report_id"], name: "index_lecture_days_on_report_id"

  create_table "lectures", force: true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.integer  "year"
    t.integer  "period"
    t.integer  "week_day"
    t.time     "lecture_start_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programs", force: true do |t|
    t.string   "name"
    t.integer  "semesters"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", force: true do |t|
    t.integer  "user_id"
    t.integer  "year"
    t.integer  "month_of_report"
    t.integer  "total_hours"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
