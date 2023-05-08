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

ActiveRecord::Schema[7.0].define(version: 2023_05_08_065435) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apes", force: :cascade do |t|
    t.string "host", null: false
    t.integer "refresh_in_hours", default: 24, null: false
    t.boolean "follow_up", default: true, null: false
    t.boolean "active", default: true, null: false
    t.datetime "last_run"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
