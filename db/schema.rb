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

ActiveRecord::Schema[7.0].define(version: 2023_05_13_125817) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "vector"

  create_table "apes", force: :cascade do |t|
    t.string "domain", null: false
    t.boolean "discovery", default: true, null: false
    t.boolean "subdomain_followup", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["domain"], name: "index_apes_on_domain", unique: true
  end

  create_table "embeddings", force: :cascade do |t|
    t.string "destination", null: false
    t.string "md5sum_gpt_content", null: false
    t.vector "v", limit: 1536
    t.bigint "scrape_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["destination"], name: "index_embeddings_on_destination", unique: true
    t.index ["md5sum_gpt_content"], name: "index_embeddings_on_md5sum_gpt_content", unique: true
    t.index ["scrape_id"], name: "index_embeddings_on_scrape_id"
  end

  create_table "links", force: :cascade do |t|
    t.string "destination", null: false
    t.bigint "ape_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ape_id"], name: "index_links_on_ape_id"
    t.index ["destination"], name: "index_links_on_destination", unique: true
  end

  create_table "scrapes", force: :cascade do |t|
    t.text "content", null: false
    t.text "gpt_content"
    t.string "md5sum", null: false
    t.bigint "ape_id"
    t.bigint "link_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ape_id"], name: "index_scrapes_on_ape_id"
    t.index ["link_id"], name: "index_scrapes_on_link_id"
    t.index ["md5sum"], name: "index_scrapes_on_md5sum", unique: true
  end

  add_foreign_key "embeddings", "scrapes"
  add_foreign_key "links", "apes"
  add_foreign_key "scrapes", "apes"
  add_foreign_key "scrapes", "links"
end
