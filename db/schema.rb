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

ActiveRecord::Schema.define(version: 20171103012027) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "goal_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "goals", force: :cascade do |t|
    t.string "name"
    t.bigint "goal_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["goal_category_id"], name: "index_goals_on_goal_category_id"
  end

  create_table "goals_observables", force: :cascade do |t|
    t.bigint "goal_id"
    t.bigint "observable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["goal_id"], name: "index_goals_observables_on_goal_id"
    t.index ["observable_id"], name: "index_goals_observables_on_observable_id"
  end

  create_table "group_memberships", force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_group_memberships_on_customer_id"
    t.index ["group_id"], name: "index_group_memberships_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "observable_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "observables", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "observable_category_id"
    t.index ["observable_category_id"], name: "index_observables_on_observable_category_id"
  end

  create_table "project_goals", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "goal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["goal_id"], name: "index_project_goals_on_goal_id"
    t.index ["project_id"], name: "index_project_goals_on_project_id"
  end

  create_table "project_observables", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "observable_id"
    t.boolean "ignored"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["observable_id"], name: "index_project_observables_on_observable_id"
    t.index ["project_id"], name: "index_project_observables_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.date "begin"
    t.date "end"
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_projects_on_customer_id"
  end

  create_table "sceance_customer_observables", force: :cascade do |t|
    t.bigint "sceance_customer_id"
    t.bigint "project_observable_id"
    t.integer "note"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_observable_id"], name: "index_sceance_customer_observables_on_project_observable_id"
    t.index ["sceance_customer_id"], name: "index_sceance_customer_observables_on_sceance_customer_id"
    t.index ["user_id"], name: "index_sceance_customer_observables_on_user_id"
  end

  create_table "sceance_customers", force: :cascade do |t|
    t.bigint "sceance_id"
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "project_id"
    t.index ["customer_id"], name: "index_sceance_customers_on_customer_id"
    t.index ["project_id"], name: "index_sceance_customers_on_project_id"
    t.index ["sceance_id"], name: "index_sceance_customers_on_sceance_id"
  end

  create_table "sceance_groups", force: :cascade do |t|
    t.bigint "sceance_id"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_sceance_groups_on_group_id"
    t.index ["sceance_id"], name: "index_sceance_groups_on_sceance_id"
  end

  create_table "sceance_users", force: :cascade do |t|
    t.bigint "sceance_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sceance_id"], name: "index_sceance_users_on_sceance_id"
    t.index ["user_id"], name: "index_sceance_users_on_user_id"
  end

  create_table "sceances", force: :cascade do |t|
    t.datetime "begin"
    t.datetime "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "sceance_customers", "projects"
end
