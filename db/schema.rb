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

ActiveRecord::Schema.define(version: 20150205222224) do

  create_table "action_type", primary_key: "action_type_id", force: :cascade do |t|
    t.string "description"
  end

  create_table "application", primary_key: "application_id", force: :cascade do |t|
    t.string  "name"
    t.text    "description"
    t.integer "disposition_id"
    t.integer "maturity_id"
    t.integer "owner_id"
    t.integer "admin_id"
    t.integer "technical_id"
    t.integer "testing_id"
    t.boolean "legacy_flag"
    t.string  "go_live"
  end

  add_index "application", ["admin_id"], name: "admin_id_idx"
  add_index "application", ["disposition_id"], name: "application_disposition_id_idx"
  add_index "application", ["maturity_id"], name: "maturity_id_idx"
  add_index "application", ["owner_id"], name: "application_owner_id_idx"
  add_index "application", ["technical_id"], name: "technical_id_idx"
  add_index "application", ["testing_id"], name: "testing_id_idx"

  create_table "business_process", primary_key: "business_process_id", force: :cascade do |t|
    t.string  "name",              limit: 255
    t.string  "description",       limit: 255
    t.integer "functional_org_id"
  end

  add_index "business_process", ["functional_org_id"], name: "functional_org_id_idx"

  create_table "business_process_app", primary_key: "business_process_app_id", force: :cascade do |t|
    t.integer "application_id"
    t.integer "business_process_id"
  end

  add_index "business_process_app", ["application_id"], name: "business_process_app_application_id_idx"
  add_index "business_process_app", ["business_process_id"], name: "business_process_id_idx"

  create_table "criticality", primary_key: "criticality_id", force: :cascade do |t|
    t.string "description"
  end

  create_table "data_combination", primary_key: "data_combination_id", force: :cascade do |t|
    t.text "combination_logic"
  end

  create_table "data_edo", primary_key: "data_edo_id", force: :cascade do |t|
    t.integer "data_field_id"
    t.integer "edo_id"
    t.string  "cardinality"
  end

  add_index "data_edo", ["data_field_id"], name: "data_edo_data_field_id_idx"
  add_index "data_edo", ["edo_id"], name: "data_edo_edo_id_idx"

  create_table "data_field", primary_key: "data_field_id", force: :cascade do |t|
    t.string  "name"
    t.text    "description"
    t.integer "data_type_id"
    t.string  "length"
    t.boolean "nullable"
    t.string  "default"
    t.text    "validation"
    t.text    "notes"
    t.boolean "legacy_flag"
    t.integer "last_action_id"
  end

  add_index "data_field", ["data_type_id"], name: "data_type_id_idx"
  add_index "data_field", ["last_action_id"], name: "data_field_last_action_id_idx"

  create_table "data_mapping", primary_key: "data_mapping_id", force: :cascade do |t|
    t.integer "source_field_id"
    t.integer "source_combination_id"
    t.integer "result_field_id"
    t.integer "result_combination_id"
    t.text    "transformation"
  end

  add_index "data_mapping", ["result_combination_id"], name: "result_combination_id_idx"
  add_index "data_mapping", ["result_field_id"], name: "result_field_id_idx"
  add_index "data_mapping", ["source_combination_id"], name: "source_combination_id_idx"
  add_index "data_mapping", ["source_field_id"], name: "source_field_id_idx"

  create_table "data_type", primary_key: "data_type_id", force: :cascade do |t|
    t.string "description"
  end

  create_table "disposition", primary_key: "disposition_id", force: :cascade do |t|
    t.string "description"
  end

  create_table "edo", primary_key: "edo_id", force: :cascade do |t|
    t.string  "name"
    t.text    "description"
    t.integer "sor_id"
    t.integer "security_level_id"
    t.string  "version"
    t.string  "repository_uri"
    t.integer "last_action_id"
  end

  add_index "edo", ["last_action_id"], name: "edo_last_action_id_idx"
  add_index "edo", ["security_level_id"], name: "security_level_id_idx"
  add_index "edo", ["sor_id"], name: "sor_id_idx"

  create_table "field_combination", primary_key: "field_combination_id", force: :cascade do |t|
    t.integer "data_combination_id"
    t.integer "data_field_id"
  end

  add_index "field_combination", ["data_combination_id"], name: "data_combination_id_idx"
  add_index "field_combination", ["data_field_id"], name: "field_combination_data_field_id_idx"

  create_table "integration", primary_key: "integration_id", force: :cascade do |t|
    t.integer "source_interface_id"
    t.integer "target_interface_id"
    t.integer "owner_id"
    t.string  "name"
    t.text    "description"
    t.text    "security"
    t.integer "criticality_id"
    t.string  "version"
    t.string  "legacy_source"
    t.string  "legacy_target"
    t.text    "legacy_notes"
    t.string  "reference_uri"
    t.string  "jira_uri"
    t.integer "last_action_id"
  end

  add_index "integration", ["criticality_id"], name: "criticality_id_idx"
  add_index "integration", ["last_action_id"], name: "integration_last_action_id_idx"
  add_index "integration", ["owner_id"], name: "integration_owner_id_idx"
  add_index "integration", ["source_interface_id"], name: "source_interface_id_idx"
  add_index "integration", ["target_interface_id"], name: "target_interface_id_idx"

  create_table "interface", primary_key: "interface_id", force: :cascade do |t|
    t.integer "application_id"
    t.string  "name"
    t.text    "description"
    t.integer "disposition_id"
    t.integer "outbound_message_id"
    t.integer "inbound_message_id"
    t.integer "transfer_method_id"
    t.text    "batch_run_frequency"
    t.text    "batch_execution_method"
    t.text    "batch_execution_restrictions"
    t.string  "batch_data_source_uri"
    t.string  "batch_data_target_uri"
    t.integer "web_service_type_id"
    t.string  "web_service_uri"
    t.text    "web_service_operations"
    t.text    "web_service_errors"
    t.integer "messaging_type_id"
    t.string  "messaging_topic"
    t.string  "messaging_queue"
    t.text    "custom_desc"
    t.string  "monitoring_endpoint"
    t.text    "recovery_process"
    t.boolean "legacy_flag"
    t.string  "reference_uri"
    t.string  "jira_uri"
    t.integer "last_action_id"
  end

  add_index "interface", ["application_id"], name: "interface_application_id_idx"
  add_index "interface", ["disposition_id"], name: "interface_disposition_id_idx"
  add_index "interface", ["inbound_message_id"], name: "inbound_message_id_idx"
  add_index "interface", ["last_action_id"], name: "interface_last_action_id_idx"
  add_index "interface", ["messaging_type_id"], name: "messaging_type_id_idx"
  add_index "interface", ["outbound_message_id"], name: "outbound_message_id_idx"
  add_index "interface", ["transfer_method_id"], name: "transfer_method_id_idx"
  add_index "interface", ["web_service_type_id"], name: "web_service_type_id_idx"

  create_table "maturity", primary_key: "maturity_id", force: :cascade do |t|
    t.string "description"
  end

  create_table "message", primary_key: "message_id", force: :cascade do |t|
    t.string  "name"
    t.text    "description"
    t.integer "message_format_id"
    t.string  "version"
    t.integer "disposition_id"
    t.string  "reference_uri"
    t.integer "last_action_id"
  end

  add_index "message", ["disposition_id"], name: "message_disposition_id_idx"
  add_index "message", ["last_action_id"], name: "message_last_action_id_idx"
  add_index "message", ["message_format_id"], name: "message_format_id_idx"

  create_table "message_data", primary_key: "message_data_id", force: :cascade do |t|
    t.integer "message_id"
    t.integer "data_field_id"
    t.string  "cardinality"
  end

  add_index "message_data", ["data_field_id"], name: "message_data_data_field_id_idx"
  add_index "message_data", ["message_id"], name: "message_data_message_id_idx"

  create_table "message_edo", primary_key: "message_edo_id", force: :cascade do |t|
    t.integer "message_id"
    t.integer "edo_id"
    t.string  "cardinality"
  end

  add_index "message_edo", ["edo_id"], name: "message_edo_edo_id_idx"
  add_index "message_edo", ["message_id"], name: "message_edo_message_id_idx"

  create_table "message_format", primary_key: "message_format_id", force: :cascade do |t|
    t.string "description"
  end

  create_table "messaging_type", primary_key: "messaging_type_id", force: :cascade do |t|
    t.string "description"
  end

  create_table "organization", primary_key: "organization_id", force: :cascade do |t|
    t.string "name"
    t.text   "description"
  end

  create_table "person", primary_key: "person_id", force: :cascade do |t|
    t.integer "organization_id"
    t.integer "calnet_uid"
    t.string  "name"
    t.string  "position"
    t.string  "email"
    t.string  "phone"
  end

  add_index "person", ["calnet_uid"], name: "calnet_uid_idx"
  add_index "person", ["organization_id"], name: "organization_id_idx"

  create_table "person_role", primary_key: "person_role_id", force: :cascade do |t|
    t.integer "role_id"
    t.integer "person_id"
  end

  add_index "person_role", ["person_id"], name: "person_id_idx"
  add_index "person_role", ["role_id"], name: "role_id_idx"

  create_table "project_action", primary_key: "project_action_id", force: :cascade do |t|
    t.string  "entity"
    t.integer "action_type_id"
    t.integer "actor_id"
    t.date    "date"
    t.text    "description"
  end

  add_index "project_action", ["action_type_id"], name: "action_type_id_idx"
  add_index "project_action", ["actor_id"], name: "actor_id_idx"
  add_index "project_action", ["entity"], name: "entity_idx"

  create_table "role", primary_key: "role_id", force: :cascade do |t|
    t.string "name"
    t.text   "description"
  end

  create_table "security_level", primary_key: "security_level_id", force: :cascade do |t|
    t.string "description"
  end

  create_table "transfer_method", primary_key: "transfer_method_id", force: :cascade do |t|
    t.string "description"
  end

  create_table "web_service_type", primary_key: "web_service_type_id", force: :cascade do |t|
    t.string "description"
  end

end
