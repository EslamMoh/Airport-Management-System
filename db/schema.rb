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

ActiveRecord::Schema.define(version: 20190512020842) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "airlines", force: :cascade do |t|
    t.string "name"
    t.string "origin_country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "airplanes", force: :cascade do |t|
    t.string "manufacturer"
    t.string "model_number"
    t.integer "capacity"
    t.integer "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "airline_id"
    t.index ["airline_id"], name: "index_airplanes_on_airline_id"
  end

  create_table "airport_airlines", force: :cascade do |t|
    t.bigint "airport_id"
    t.bigint "airline_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["airline_id"], name: "index_airport_airlines_on_airline_id"
    t.index ["airport_id"], name: "index_airport_airlines_on_airport_id"
  end

  create_table "airports", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "country"
    t.index ["user_id"], name: "index_airports_on_user_id"
  end

  create_table "flight_executions", force: :cascade do |t|
    t.bigint "airplane_id"
    t.bigint "departure_terminal_id"
    t.bigint "destination_terminal_id"
    t.datetime "departure_time"
    t.datetime "arrival_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["airplane_id"], name: "index_flight_executions_on_airplane_id"
    t.index ["departure_terminal_id"], name: "index_flight_executions_on_departure_terminal_id"
    t.index ["destination_terminal_id"], name: "index_flight_executions_on_destination_terminal_id"
  end

  create_table "flight_flight_executions", force: :cascade do |t|
    t.bigint "flight_id"
    t.bigint "flight_execution_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flight_execution_id"], name: "index_flight_flight_executions_on_flight_execution_id"
    t.index ["flight_id"], name: "index_flight_flight_executions_on_flight_id"
  end

  create_table "flights", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.string "type"
    t.string "direction_type"
    t.string "status"
    t.string "departure_country"
    t.string "destination_country"
    t.bigint "departure_airport_id"
    t.bigint "destination_airport_id"
    t.datetime "departure_time"
    t.datetime "arrival_time"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["departure_airport_id"], name: "index_flights_on_departure_airport_id"
    t.index ["destination_airport_id"], name: "index_flights_on_destination_airport_id"
  end

  create_table "passengers", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "country"
    t.string "address"
    t.string "email"
    t.string "birth_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "seats", force: :cascade do |t|
    t.bigint "ticket_id"
    t.bigint "flight_execution_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flight_execution_id"], name: "index_seats_on_flight_execution_id"
  end

  create_table "terminals", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "airport_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["airport_id"], name: "index_terminals_on_airport_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.bigint "flight_id"
    t.bigint "passenger_id"
    t.string "payment_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flight_id"], name: "index_tickets_on_flight_id"
    t.index ["passenger_id"], name: "index_tickets_on_passenger_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "country"
    t.string "email"
    t.json "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  add_foreign_key "airplanes", "airlines"
  add_foreign_key "airport_airlines", "airlines"
  add_foreign_key "airport_airlines", "airports"
  add_foreign_key "airports", "users"
  add_foreign_key "flight_executions", "airplanes"
  add_foreign_key "flight_executions", "terminals", column: "departure_terminal_id"
  add_foreign_key "flight_executions", "terminals", column: "destination_terminal_id"
  add_foreign_key "flight_flight_executions", "flight_executions"
  add_foreign_key "flight_flight_executions", "flights"
  add_foreign_key "flights", "airports", column: "departure_airport_id"
  add_foreign_key "flights", "airports", column: "destination_airport_id"
  add_foreign_key "seats", "flight_executions"
  add_foreign_key "seats", "tickets"
  add_foreign_key "terminals", "airports"
  add_foreign_key "tickets", "flights"
  add_foreign_key "tickets", "passengers"
end
