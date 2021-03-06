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

ActiveRecord::Schema.define(version: 2020_03_13_030104) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
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

  create_table "administrations", force: :cascade do |t|
    t.time "time"
    t.integer "dose"
    t.integer "cummulative_dose"
    t.bigint "case_drug_id"
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
    t.bigint "organization_id"
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
    t.bigint "case_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "rule_id"
    t.index ["case_id"], name: "index_case_drugs_on_case_id"
    t.index ["rule_id"], name: "index_case_drugs_on_rule_id"
  end

  create_table "cases", force: :cascade do |t|
    t.integer "age"
    t.integer "weight"
    t.bigint "paramedic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["paramedic_id"], name: "index_cases_on_paramedic_id"
  end

  create_table "drugs", force: :cascade do |t|
    t.string "name"
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_drugs_on_organization_id"
  end

  create_table "indications", force: :cascade do |t|
    t.string "name"
    t.bigint "presentation_id"
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
    t.bigint "organization_id"
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
    t.bigint "paramedic_type_id"
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
    t.string "drug_unit"
    t.integer "volume"
    t.string "volume_unit"
    t.bigint "drug_id"
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
    t.integer "repeat_dose"
    t.integer "min_interval"
    t.integer "max_interval"
    t.integer "min_weight"
    t.integer "max_weight"
    t.string "calc_type"
    t.bigint "paramedic_type_id"
    t.bigint "route_id"
    t.bigint "indication_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "interval_unit"
    t.integer "min_initial_dose"
    t.integer "max_initial_dose"
    t.integer "max_single_dose"
    t.integer "max_total_dose"
    t.string "dose_unit"
    t.string "patient_type"
    t.index ["indication_id"], name: "index_rules_on_indication_id"
    t.index ["paramedic_type_id"], name: "index_rules_on_paramedic_type_id"
    t.index ["route_id"], name: "index_rules_on_route_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "administrations", "case_drugs"
  add_foreign_key "admins", "organizations"
  add_foreign_key "case_drugs", "cases"
  add_foreign_key "case_drugs", "rules"
  add_foreign_key "cases", "paramedics"
  add_foreign_key "drugs", "organizations"
  add_foreign_key "indications", "presentations"
  add_foreign_key "paramedic_types", "organizations"
  add_foreign_key "paramedics", "paramedic_types"
  add_foreign_key "presentations", "drugs"
  add_foreign_key "rules", "indications"
  add_foreign_key "rules", "paramedic_types"
  add_foreign_key "rules", "routes"
end
