# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_30_205040) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "apply_vacancies", force: :cascade do |t|
    t.integer "profile_id", null: false
    t.integer "vacancy_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "apply_message"
    t.index ["profile_id"], name: "index_apply_vacancies_on_profile_id"
    t.index ["vacancy_id"], name: "index_apply_vacancies_on_vacancy_id"
  end

  create_table "candidates", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_candidates_on_email", unique: true
    t.index ["reset_password_token"], name: "index_candidates_on_reset_password_token", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.string "text"
    t.integer "headhunter_id", null: false
    t.integer "profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["headhunter_id"], name: "index_comments_on_headhunter_id"
    t.index ["profile_id"], name: "index_comments_on_profile_id"
  end

  create_table "headhunters", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_headhunters_on_email", unique: true
    t.index ["reset_password_token"], name: "index_headhunters_on_reset_password_token", unique: true
  end

  create_table "levels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string "full_name"
    t.string "social_name"
    t.date "birth_date"
    t.string "formation"
    t.string "description"
    t.string "experience"
    t.integer "candidate_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["candidate_id"], name: "index_profiles_on_candidate_id"
  end

  create_table "proposals", force: :cascade do |t|
    t.date "start_date"
    t.decimal "salary"
    t.string "benefits"
    t.string "job_functions"
    t.integer "headhunter_id", null: false
    t.integer "apply_vacancy_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.string "answer"
    t.index ["apply_vacancy_id"], name: "index_proposals_on_apply_vacancy_id"
    t.index ["headhunter_id"], name: "index_proposals_on_headhunter_id"
  end

  create_table "reject_apply_vacancies", force: :cascade do |t|
    t.string "feedback"
    t.integer "headhunter_id", null: false
    t.integer "apply_vacancy_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["apply_vacancy_id"], name: "index_reject_apply_vacancies_on_apply_vacancy_id"
    t.index ["headhunter_id"], name: "index_reject_apply_vacancies_on_headhunter_id"
  end

  create_table "star_profiles", force: :cascade do |t|
    t.integer "headhunter_id", null: false
    t.integer "profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["headhunter_id"], name: "index_star_profiles_on_headhunter_id"
    t.index ["profile_id"], name: "index_star_profiles_on_profile_id"
  end

  create_table "vacancies", force: :cascade do |t|
    t.string "title"
    t.string "job_description"
    t.string "skills"
    t.decimal "salary"
    t.date "registration_date"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "level_id", null: false
    t.integer "status", default: 0
    t.integer "headhunter_id", null: false
    t.index ["headhunter_id"], name: "index_vacancies_on_headhunter_id"
    t.index ["level_id"], name: "index_vacancies_on_level_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "apply_vacancies", "profiles"
  add_foreign_key "apply_vacancies", "vacancies"
  add_foreign_key "comments", "headhunters"
  add_foreign_key "comments", "profiles"
  add_foreign_key "profiles", "candidates"
  add_foreign_key "proposals", "apply_vacancies"
  add_foreign_key "proposals", "headhunters"
  add_foreign_key "reject_apply_vacancies", "apply_vacancies"
  add_foreign_key "reject_apply_vacancies", "headhunters"
  add_foreign_key "star_profiles", "headhunters"
  add_foreign_key "star_profiles", "profiles"
  add_foreign_key "vacancies", "headhunters"
  add_foreign_key "vacancies", "levels"
end
