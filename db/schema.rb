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

ActiveRecord::Schema.define(version: 2019_12_19_153625) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.integer "account_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_type_id"], name: "index_accounts_on_account_type_id"
  end

  create_table "balances", force: :cascade do |t|
    t.integer "account_id"
    t.date "date"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_balances_on_account_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "start_date", null: false
    t.date "end_date"
    t.boolean "billable", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "direct_experience", default: 0, null: false
    t.integer "indirect_experience", default: 0, null: false
    t.decimal "starting_salary", default: "0.0", null: false
    t.text "notes"
    t.date "planning_raise_date"
    t.string "planning_raise_salary"
    t.text "planning_notes"
  end

  create_table "salaries", force: :cascade do |t|
    t.date "start_date", null: false
    t.integer "employee_id", null: false
    t.decimal "annual_amount", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["employee_id"], name: "index_salaries_on_employee_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.integer "invited_by_id"
    t.string "invited_by_type"
    t.integer "invitations_count", default: 0
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id", "invited_by_type"], name: "index_users_on_invited_by_id_and_invited_by_type"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "balances", "accounts"
  add_foreign_key "salaries", "employees", name: "salaries_employee_id_fk"
end
