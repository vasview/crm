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

ActiveRecord::Schema.define(version: 20170904053144) do

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
    t.integer "committee_id"
    t.integer "representative_id"
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
    t.integer "category_id"
    t.integer "industry_id"
    t.integer "city_id"
    t.string "address"
    t.string "work_phone"
    t.string "mobile_phone"
    t.string "email"
    t.date "birthdate"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_companies_on_category_id"
    t.index ["city_id"], name: "index_companies_on_city_id"
    t.index ["industry_id"], name: "index_companies_on_industry_id"
  end

  create_table "executives", force: :cascade do |t|
    t.integer "company_id"
    t.integer "representative_id"
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
  end

  create_table "interaction_results", force: :cascade do |t|
    t.float "mark"
    t.integer "company_id"
    t.integer "interaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_interaction_results_on_company_id"
    t.index ["interaction_id"], name: "index_interaction_results_on_interaction_id"
  end

  create_table "interactions", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "company_id"
    t.integer "representative_id"
    t.integer "service_id"
    t.integer "user_id"
    t.string "classifiable_type"
    t.integer "classifiable_id"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classifiable_type", "classifiable_id"], name: "index_interactions_on_classifiable_type_and_classifiable_id"
    t.index ["company_id"], name: "index_interactions_on_company_id"
    t.index ["representative_id"], name: "index_interactions_on_representative_id"
    t.index ["service_id"], name: "index_interactions_on_service_id"
    t.index ["user_id"], name: "index_interactions_on_user_id"
  end

  create_table "job_positions", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "representatives", force: :cascade do |t|
    t.string "firstname"
    t.string "middlename"
    t.string "lastname"
    t.string "work_phone"
    t.string "mobile_phone"
    t.string "email"
    t.integer "company_id"
    t.integer "job_position_id"
    t.date "birthdate"
    t.text "notes"
    t.boolean "company_head"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fullname"
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
  end

  create_table "users", force: :cascade do |t|
    t.string "firstname"
    t.string "middlename"
    t.string "lastname"
    t.string "work_phone"
    t.string "mobile_phone"
    t.integer "job_position_id"
    t.integer "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fullname"
    t.string "email"
    t.index ["job_position_id"], name: "index_users_on_job_position_id"
    t.index ["role_id"], name: "index_users_on_role_id"
  end

end
