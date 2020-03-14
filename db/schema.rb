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

ActiveRecord::Schema.define(version: 2020_03_14_183245) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "issue_events", force: :cascade do |t|
    t.string "action"
    t.jsonb "issue_changes"
    t.string "sender"
    t.bigint "issue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["issue_id"], name: "index_issue_events_on_issue_id"
  end

  create_table "issues", force: :cascade do |t|
    t.integer "number"
    t.string "title"
    t.string "state"
    t.boolean "locked"
    t.integer "github_id"
    t.integer "github_user_id"
    t.string "github_url"
    t.datetime "github_created_at"
    t.datetime "github_updated_at"
    t.datetime "github_closed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "repository_id"
    t.index ["repository_id"], name: "index_issues_on_repository_id"
  end

  create_table "repositories", force: :cascade do |t|
    t.string "username"
    t.string "name"
    t.uuid "token", default: -> { "uuid_generate_v4()" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_repositories_on_token"
  end

  add_foreign_key "issue_events", "issues"
  add_foreign_key "issues", "repositories"
end
