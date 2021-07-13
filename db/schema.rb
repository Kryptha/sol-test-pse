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

ActiveRecord::Schema.define(version: 2021_06_28_011127) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cheap_routes", force: :cascade do |t|
    t.string "from"
    t.string "to"
    t.string "airline"
    t.decimal "price"
    t.datetime "departs_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "route_captures", force: :cascade do |t|
    t.text "raw_payload"
    t.string "from"
    t.string "to"
    t.string "aasm_state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "route_options", force: :cascade do |t|
    t.string "from"
    t.string "to"
    t.datetime "departs_at"
    t.datetime "arrives_at"
    t.bigint "route_capture_id", null: false
    t.string "airline_ref"
    t.text "raw_payload"
    t.decimal "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["route_capture_id"], name: "index_route_options_on_route_capture_id"
  end

  add_foreign_key "route_options", "route_captures"
end
