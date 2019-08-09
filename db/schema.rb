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

ActiveRecord::Schema.define(version: 2019_08_13_171932) do

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

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "antibiotic_consumption_stats", force: :cascade do |t|
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "antibiotic_id"
    t.boolean "issued"
    t.integer "quantity"
    t.integer "balance"
    t.string "recipient_facility"
    t.string "recipient_unit"
    t.index ["antibiotic_id"], name: "index_antibiotic_consumption_stats_on_antibiotic_id"
  end

  create_table "antibiotics", force: :cascade do |t|
    t.string "name"
    t.string "strength_value"
    t.string "strength_unit"
    t.string "form"
    t.string "pack_size"
    t.string "brand"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "who_atc_index"
  end

  create_table "clinical_services", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "culture_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lab_record_imports", force: :cascade do |t|
    t.integer "header_row"
    t.integer "data_rows_from"
    t.integer "data_rows_to"
    t.jsonb "rows"
    t.jsonb "columns"
    t.jsonb "patient_or_lab_record_id"
    t.jsonb "phi"
    t.jsonb "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "site_id"
    t.index ["site_id"], name: "index_lab_record_imports_on_site_id"
  end

  create_table "lab_records", force: :cascade do |t|
    t.bigint "lab_record_import_id"
    t.bigint "site_id"
    t.integer "patient_id_state", default: 0
    t.integer "row"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "patient_id"
    t.index ["lab_record_import_id"], name: "index_lab_records_on_lab_record_import_id"
    t.index ["site_id"], name: "index_lab_records_on_site_id"
  end

  create_table "patient_entries", force: :cascade do |t|
    t.bigint "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
    t.string "department"
    t.string "admission_date"
    t.string "discharge_date"
    t.string "weight"
    t.string "height"
    t.boolean "pregnancy_status"
    t.boolean "premature_birth"
    t.string "chief_complaint"
    t.boolean "patient_transferred"
    t.string "primary_diagnosis"
    t.string "primary_diagnosis_icd_code"
    t.boolean "acute_myocardial_infarction"
    t.boolean "chf"
    t.boolean "not_mentioned"
    t.boolean "other"
    t.boolean "antibiotics_prescribed"
    t.string "antibiotic"
    t.string "antibiotic_consumption"
    t.boolean "patient_was_on_an_indwelling_medical_device"
    t.string "medical_device"
    t.string "infection_acquisition"
    t.string "discharge_diagnostic"
    t.string "discharge_diagnostic_icd_code"
    t.string "patient_outcome_at_discharge"
    t.bigint "stay_timespan"
    t.index ["patient_id"], name: "index_patient_entries_on_patient_id"
  end

  create_table "patient_id_hashes", force: :cascade do |t|
    t.string "patient_id"
    t.string "hashed_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "site_id"
    t.index ["patient_id"], name: "index_patient_id_hashes_on_patient_id"
    t.index ["site_id"], name: "index_patient_id_hashes_on_site_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "gender"
    t.integer "year_of_birth"
    t.string "level_of_education"
    t.string "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "site_id"
    t.string "patient_id_state", default: "pending"
    t.index ["site_id"], name: "index_patients_on_site_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "location"
    t.string "ownership"
    t.boolean "has_farmacy"
    t.boolean "identified_patients"
    t.boolean "permanently_identified_patients"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "level"
    t.string "teaching"
    t.boolean "has_hospital"
    t.boolean "has_laboratory"
  end

  create_table "specimen_sources", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "antibiotic_consumption_stats", "antibiotics"
  add_foreign_key "lab_record_imports", "sites"
  add_foreign_key "lab_records", "lab_record_imports"
  add_foreign_key "lab_records", "sites"
  add_foreign_key "patient_entries", "patients"
  add_foreign_key "patient_id_hashes", "sites"
  add_foreign_key "patients", "sites"
end
