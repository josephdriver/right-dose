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

ActiveRecord::Schema.define(version: 2020_03_10_025307) do

  create_table "administrations", force: :cascade do |t|
    t.time "time"
    t.integer "dose"
    t.integer "cummulative_dose"
    t.integer "case_drug_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_drug_id"], name: "index_administrations_on_case_drug_id"
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "employee_num"
    t.integer "organization_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["organization_id"], name: "index_admins_on_organization_id"
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "case_drugs", force: :cascade do |t|
    t.integer "case_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rule_id"
    t.index ["case_id"], name: "index_case_drugs_on_case_id"
    t.index ["rule_id"], name: "index_case_drugs_on_rule_id"
  end

  create_table "cases", force: :cascade do |t|
    t.integer "age"
    t.integer "weight"
    t.integer "paramedic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["paramedic_id"], name: "index_cases_on_paramedic_id"
  end

  create_table "drugs", force: :cascade do |t|
    t.string "name"
    t.integer "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_drugs_on_organization_id"
  end

  create_table "indications", force: :cascade do |t|
    t.string "name"
    t.integer "presentation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["presentation_id"], name: "index_indications_on_presentation_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.integer "pediatric_cutoff"
    t.integer "multiplier"
    t.integer "addition_num"
    t.integer "weight_6mth"
    t.integer "weight_3mth"
    t.string "weight_unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "paramedic_types", force: :cascade do |t|
    t.string "title"
    t.string "acronym"
    t.integer "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_paramedic_types_on_organization_id"
  end

  create_table "paramedics", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "employee_num"
    t.integer "paramedic_type_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_paramedics_on_email", unique: true
    t.index ["paramedic_type_id"], name: "index_paramedics_on_paramedic_type_id"
    t.index ["reset_password_token"], name: "index_paramedics_on_reset_password_token", unique: true
  end

  create_table "presentations", force: :cascade do |t|
    t.integer "dose"
    t.string "dose_unit"
    t.integer "volume"
    t.string "volume_unit"
    t.integer "drug_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drug_id"], name: "index_presentations_on_drug_id"
  end

  create_table "routes", force: :cascade do |t|
    t.string "name"
    t.string "acronym"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rules", force: :cascade do |t|
    t.integer "min_age"
    t.integer "max_age"
    t.integer "initial_dose"
    t.integer "repeat_dose"
    t.integer "min_interval"
    t.integer "max_interval"
    t.integer "min_weight"
    t.integer "max_weight"
    t.string "calc_type"
    t.integer "paramedic_type_id"
    t.integer "route_id"
    t.integer "indication_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["indication_id"], name: "index_rules_on_indication_id"
    t.index ["paramedic_type_id"], name: "index_rules_on_paramedic_type_id"
    t.index ["route_id"], name: "index_rules_on_route_id"
  end

end
