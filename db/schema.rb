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

ActiveRecord::Schema.define(version: 2020_04_27_072327) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.string "email"
    t.string "password_digest"
    t.boolean "admin", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
  end

  create_table "glosses", force: :cascade do |t|
    t.string "gloss"
    t.bigint "lemma_id", null: false
    t.bigint "story_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lemma_id"], name: "index_glosses_on_lemma_id"
    t.index ["story_id"], name: "index_glosses_on_story_id"
  end

  create_table "lemmas", force: :cascade do |t|
    t.string "lemma"
    t.string "lexical_category"
    t.string "class"
    t.string "notes"
    t.string "origin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stories", force: :cascade do |t|
    t.string "story_title"
    t.text "story"
    t.bigint "author_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_id"], name: "index_stories_on_author_id"
  end

  add_foreign_key "glosses", "lemmas"
  add_foreign_key "glosses", "stories"
  add_foreign_key "stories", "authors"
end
