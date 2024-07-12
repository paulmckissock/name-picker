# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_07_10_152700) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "participants", force: :cascade do |t|
    t.bigint "wheel_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "has_won", default: false, null: false
    t.index ["wheel_id"], name: "index_participants_on_wheel_id"
  end

  create_table "results", force: :cascade do |t|
    t.bigint "participant_id", null: false
    t.bigint "user_id"
    t.bigint "wheel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participant_id"], name: "index_results_on_participant_id"
    t.index ["user_id"], name: "index_results_on_user_id"
    t.index ["wheel_id"], name: "index_results_on_wheel_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wheels", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "participants_count", default: 0, null: false
    t.index ["user_id"], name: "index_wheels_on_user_id"
  end

  add_foreign_key "participants", "wheels"
  add_foreign_key "results", "participants"
  add_foreign_key "results", "users"
  add_foreign_key "results", "wheels"
  add_foreign_key "wheels", "users"
end
