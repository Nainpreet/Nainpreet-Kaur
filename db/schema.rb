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

ActiveRecord::Schema.define(version: 20170418101328) do

  create_table "appointments", force: :cascade do |t|
    t.date    "app_date"
    t.date    "date"
    t.string  "time_slots"
    t.string  "symptoms"
    t.string  "medications"
    t.string  "status",        default: "Pending"
    t.integer "department_id"
    t.integer "user_id"
    t.integer "doctor_id"
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
  end

  create_table "doctors", force: :cascade do |t|
    t.string  "time_slots"
    t.string  "days"
    t.integer "user_id"
    t.integer "department_id"
    t.index ["department_id"], name: "index_doctors_on_department_id"
    t.index ["user_id"], name: "index_doctors_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "role"
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.date     "dob"
    t.string   "gender"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "verification_code"
    t.boolean  "is_verified"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
