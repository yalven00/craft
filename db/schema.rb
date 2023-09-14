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

ActiveRecord::Schema.define(version: 20140526082146) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "assets", force: true do |t|
    t.string   "description",       default: ""
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "asset_type",        default: "asset"
    t.string   "for_model",         default: "project"
    t.integer  "mid"
    t.integer  "user_id"
  end

  create_table "attachments", force: true do |t|
    t.integer  "company_id"
    t.string   "attachment_type", default: ""
    t.string   "description",     default: ""
    t.text     "embed",           default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file"
    t.integer  "order",           default: 0
  end

  create_table "authentications", force: true do |t|
    t.integer  "user_id"
    t.string   "uid",        default: ""
    t.string   "provider",   default: ""
    t.string   "secret",     default: ""
    t.string   "token",      default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name",        default: ""
    t.integer  "industry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.text     "company_type",               default: ""
    t.text     "description",                default: ""
    t.string   "name",                       default: ""
    t.string   "site",                       default: ""
    t.string   "founded_year",               default: ""
    t.integer  "twitter_followers",          default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hiring",                     default: false
    t.string   "stage",                      default: ""
    t.string   "careers_page",               default: ""
    t.string   "crunchbase",                 default: ""
    t.string   "google_finance",             default: ""
    t.string   "wikipedia",                  default: ""
    t.string   "duedil",                     default: ""
    t.string   "glassdoor",                  default: ""
    t.string   "linkedin",                   default: ""
    t.string   "twitter",                    default: ""
    t.text     "investors",                  default: ""
    t.integer  "buzz",                       default: 0
    t.integer  "strength",                   default: 0
    t.integer  "employees",                  default: 0
    t.integer  "previous_employees",         default: 0
    t.decimal  "total_funding",              default: 0.0
    t.decimal  "last_funding",               default: 0.0
    t.date     "last_funding_date"
    t.integer  "category_id"
    t.integer  "previous_twitter_followers", default: 0
    t.string   "blog",                       default: ""
    t.float    "growth",                     default: 0.0
    t.boolean  "hidden",                     default: false
    t.text     "full_description",           default: ""
    t.decimal  "revenue",                    default: 0.0
    t.decimal  "valuation",                  default: 0.0
    t.string   "ticket"
  end

  create_table "compensations", force: true do |t|
    t.string   "currency",          default: "USD"
    t.string   "title",             default: ""
    t.string   "rate_type",         default: "hour"
    t.string   "notes",             default: ""
    t.string   "equity",            default: ""
    t.string   "position_type",     default: "full_time"
    t.string   "company",           default: ""
    t.string   "location",          default: ""
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "user_id"
    t.integer  "bonus",             default: 0
    t.integer  "number",            default: 0
    t.integer  "percent_of_target", default: 0
    t.integer  "actual_paid",       default: 0
    t.integer  "target",            default: 0
    t.integer  "base_salary",       default: 0
    t.integer  "total",             default: 0
    t.integer  "annual_equivalent", default: 0
    t.integer  "rate",              default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "currencies", force: true do |t|
    t.date     "date"
    t.string   "code"
    t.float    "from_usd"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "desired_jobs", force: true do |t|
    t.string   "company",     default: ""
    t.string   "industry",    default: ""
    t.string   "title",       default: ""
    t.string   "location",    default: ""
    t.string   "link",        default: ""
    t.text     "description", default: ""
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "divisions", force: true do |t|
    t.string   "name"
    t.string   "company_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "educations", force: true do |t|
    t.integer  "start_year"
    t.integer  "end_year"
    t.integer  "user_id"
    t.integer  "eid",            default: 0
    t.string   "school",         default: ""
    t.string   "degree",         default: ""
    t.string   "field_of_study", default: ""
    t.string   "grade",          default: ""
    t.text     "activities",     default: ""
    t.text     "notes",          default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employment_projections", force: true do |t|
    t.string   "code"
    t.string   "projection"
    t.string   "category"
    t.string   "number_change"
    t.string   "employment"
    t.string   "percent_change"
    t.string   "jobs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goals", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grades", force: true do |t|
    t.string   "name",       default: ""
    t.string   "number",     default: ""
    t.string   "grade",      default: ""
    t.integer  "term_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "industries", force: true do |t|
    t.string   "name",                default: ""
    t.string   "year",                default: ""
    t.string   "area_code",           default: ""
    t.string   "area_type",           default: ""
    t.string   "area",                default: ""
    t.string   "state",               default: ""
    t.string   "outlets",             default: ""
    t.string   "employment",          default: ""
    t.string   "total_wages",         default: ""
    t.string   "average_weekly_wage", default: ""
    t.string   "average_salary",      default: ""
    t.string   "employment_quotient", default: ""
    t.string   "total_wage_quotient", default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.integer  "company_id"
    t.string   "description", default: ""
    t.string   "city",        default: ""
    t.string   "country",     default: ""
    t.string   "address",     default: ""
    t.string   "state",       default: ""
    t.string   "region",      default: ""
    t.float    "latitude",    default: 0.0
    t.float    "longitude",   default: 0.0
    t.boolean  "hq",          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "market_salaries", force: true do |t|
    t.datetime "submitted_date"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "certified_begin_date"
    t.datetime "certified_end_date"
    t.datetime "dol_decision_date"
    t.boolean  "part_time",            default: false
    t.string   "case_number",          default: ""
    t.string   "program_designation",  default: ""
    t.string   "employer_name",        default: ""
    t.string   "employer_city",        default: ""
    t.string   "employer_address",     default: ""
    t.string   "employer_state",       default: ""
    t.string   "employer_postal_code", default: ""
    t.string   "nbr_immigrants",       default: ""
    t.string   "job_title",            default: ""
    t.string   "occupation_code",      default: ""
    t.string   "approval_status",      default: ""
    t.string   "wage_rate_from",       default: ""
    t.string   "wage_rate_per",        default: ""
    t.string   "wage_rate_to",         default: ""
    t.string   "work_city",            default: ""
    t.string   "work_state",           default: ""
    t.string   "prevailing_wage",      default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "median_salaries", force: true do |t|
    t.string   "title"
    t.string   "location"
    t.integer  "salary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "occupations", force: true do |t|
    t.string   "code"
    t.string   "title"
    t.string   "level"
    t.string   "group"
    t.string   "employees"
    t.string   "average_hourly"
    t.string   "average_annual"
    t.string   "percent_hourly"
    t.string   "percent_annual"
    t.string   "only"
    t.string   "area"
    t.string   "jobs"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "title"
    t.integer  "company_id"
    t.boolean  "is_past"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo"
  end

  create_table "positions", force: true do |t|
    t.integer  "user_id"
    t.integer  "pid",           default: 0
    t.string   "company",       default: ""
    t.string   "title",         default: ""
    t.string   "location",      default: ""
    t.string   "position_type", default: "full_time"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "current",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "name",            default: ""
    t.string   "status",          default: "in progress"
    t.string   "next_steps",      default: ""
    t.integer  "position_id"
    t.integer  "duration"
    t.integer  "percent_of_time", default: 0
    t.date     "end_date"
    t.date     "start_date"
    t.text     "description",     default: ""
    t.text     "manager_comment", default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "link"
  end

  create_table "teams", force: true do |t|
    t.integer  "company_id"
    t.integer  "division_id"
    t.string   "name"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url",         default: ""
    t.text     "description", default: ""
  end

  create_table "terms", force: true do |t|
    t.string   "semester",     default: ""
    t.integer  "year"
    t.integer  "education_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_list_line_items", force: true do |t|
    t.integer  "user_list_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_lists", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "first_name",             default: ""
    t.string   "last_name",              default: ""
    t.string   "country",                default: ""
    t.string   "zip",                    default: ""
    t.string   "gender",                 default: "male"
    t.date     "birth_date"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
