# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150613141535) do

  create_table "microposts", force: true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "microposts", ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "wakaran_rels", force: true do |t|
    t.integer  "wakararen_post_id"
    t.integer  "wakaran_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wakaran_rels", ["wakaran_user_id"], name: "index_wakaran_rels_on_wakaran_user_id"
  add_index "wakaran_rels", ["wakararen_post_id", "wakaran_user_id"], name: "index_wakaran_rels_on_wakararen_post_id_and_wakaran_user_id", unique: true
  add_index "wakaran_rels", ["wakararen_post_id"], name: "index_wakaran_rels_on_wakararen_post_id"

  create_table "wakaru_relations", force: true do |t|
    t.integer  "wakarareru_post_id"
    t.integer  "wakaru_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wakaru_relations", ["wakarareru_post_id", "wakaru_user_id"], name: "index_wakaru_relations_on_post_id_and_ser_id", unique: true
  add_index "wakaru_relations", ["wakarareru_post_id"], name: "index_wakaru_relations_on_wakarareru_post_id"
  add_index "wakaru_relations", ["wakaru_user_id"], name: "index_wakaru_relations_on_wakaru_user_id"

end
