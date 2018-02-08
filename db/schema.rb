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

ActiveRecord::Schema.define(version: 20180207180923) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "committee_representatives", force: :cascade do |t|
    t.bigint "committee_id"
    t.bigint "representative_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["committee_id"], name: "index_committee_representatives_on_committee_id"
    t.index ["representative_id"], name: "index_committee_representatives_on_representative_id"
  end

  create_table "committees", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.bigint "category_id"
    t.bigint "industry_id"
    t.bigint "city_id"
    t.string "address"
    t.string "work_phone"
    t.string "mobile_phone"
    t.string "email"
    t.date "birthdate"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "active"
    t.date "entry_date"
    t.date "exit_date"
    t.string "exit_reason"
    t.index ["category_id"], name: "index_companies_on_category_id"
    t.index ["city_id"], name: "index_companies_on_city_id"
    t.index ["industry_id"], name: "index_companies_on_industry_id"
  end

  create_table "executives", force: :cascade do |t|
    t.bigint "company_id"
    t.bigint "representative_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_executives_on_company_id"
    t.index ["representative_id"], name: "index_executives_on_representative_id"
  end

  create_table "industries", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
  end

  create_table "interaction_results", force: :cascade do |t|
    t.float "mark"
    t.bigint "company_id"
    t.bigint "interaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_interaction_results_on_company_id"
    t.index ["interaction_id"], name: "index_interaction_results_on_interaction_id"
  end

  create_table "interactions", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.bigint "company_id"
    t.bigint "representative_id"
    t.bigint "service_id"
    t.bigint "user_id"
    t.bigint "category_id"
    t.bigint "committee_id"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_interactions_on_category_id"
    t.index ["committee_id"], name: "index_interactions_on_committee_id"
    t.index ["company_id"], name: "index_interactions_on_company_id"
    t.index ["representative_id"], name: "index_interactions_on_representative_id"
    t.index ["service_id"], name: "index_interactions_on_service_id"
    t.index ["user_id"], name: "index_interactions_on_user_id"
  end

  create_table "job_positions", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
  end

  create_table "representatives", force: :cascade do |t|
    t.string "firstname"
    t.string "middlename"
    t.string "lastname"
    t.string "work_phone"
    t.string "mobile_phone"
    t.string "email"
    t.bigint "company_id"
    t.bigint "job_position_id"
    t.date "birthdate"
    t.text "notes"
    t.boolean "company_head"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fullname"
    t.string "preferences"
    t.index ["company_id"], name: "index_representatives_on_company_id"
    t.index ["job_position_id"], name: "index_representatives_on_job_position_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "cost"
    t.float "committee_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string "firstname"
    t.string "middlename"
    t.string "lastname"
    t.string "work_phone"
    t.string "mobile_phone"
    t.bigint "job_position_id"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fullname"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["job_position_id"], name: "index_users_on_job_position_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "committee_representatives", "committees"
  add_foreign_key "committee_representatives", "representatives"
  add_foreign_key "companies", "categories"
  add_foreign_key "companies", "cities"
  add_foreign_key "companies", "industries"
  add_foreign_key "executives", "companies"
  add_foreign_key "executives", "representatives"
  add_foreign_key "interaction_results", "companies"
  add_foreign_key "interaction_results", "interactions"
  add_foreign_key "interactions", "categories"
  add_foreign_key "interactions", "committees"
  add_foreign_key "interactions", "companies"
  add_foreign_key "interactions", "representatives"
  add_foreign_key "interactions", "services"
  add_foreign_key "interactions", "users"
  add_foreign_key "representatives", "companies"
  add_foreign_key "representatives", "job_positions"
  add_foreign_key "users", "job_positions"
  add_foreign_key "users", "roles"
end
