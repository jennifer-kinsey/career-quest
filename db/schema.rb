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

ActiveRecord::Schema.define(version: 20170517211451) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "companies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "website"
    t.string "services"
    t.string "size"
    t.string "specializations"
    t.string "pros"
    t.string "cons"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_detail_id"
  end

  create_table "contacts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "job_title"
    t.string "phone"
    t.string "email"
    t.string "linkedin"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "company_id"
    t.uuid "user_detail_id"
  end

  create_table "correspondences", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "action"
    t.string "mode"
    t.date "date"
    t.string "result"
    t.string "notes"
    t.uuid "contact_id"
    t.uuid "position_id"
    t.uuid "user_detail_id"
    t.uuid "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "positions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.string "application_status"
    t.string "description"
    t.string "offer"
    t.string "schedule"
    t.string "url"
    t.string "est_salary"
    t.string "notes"
    t.string "resume"
    t.string "cover_letter"
    t.uuid "company_id"
    t.uuid "user_detail_id"
    t.date "application_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quotes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "tip"
  end

  create_table "user_credentials", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_detail_id"
    t.string "name"
  end

  create_table "user_details", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "current_job"
    t.string "career_objectives"
    t.string "webpage"
    t.string "resume_template"
    t.string "cover_letter_template"
    t.string "skills"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_credential_id"
    t.string "name"
  end

end
