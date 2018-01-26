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

ActiveRecord::Schema.define(version: 20180126023959) do

  create_table "actions", force: :cascade do |t|
    t.integer  "action_id"
    t.integer  "chamber"
    t.string   "action_type"
    t.date     "date"
    t.string   "description"
    t.integer  "bill_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "bills", force: :cascade do |t|
    t.string   "bill_id"
    t.string   "bill_slug"
    t.string   "bill_number"
    t.string   "title"
    t.string   "short_title"
    t.string   "sponsor_id"
    t.string   "sponsor_party"
    t.string   "sponsor_state"
    t.date     "introduced_date"
    t.text     "summary"
    t.text     "short_summary"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "latest_major_action",      default: ""
    t.date     "latest_major_action_date"
  end

  create_table "govt_officials", id: false, force: :cascade do |t|
    t.string   "member_id"
    t.string   "firstName"
    t.string   "lastName"
    t.date     "DOB"
    t.string   "twitter"
    t.integer  "chamber"
    t.string   "title"
    t.string   "state"
    t.string   "party"
    t.integer  "nextElection"
    t.decimal  "votesWithParty"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "image_string"
    t.integer  "bills_sponsored"
    t.integer  "bills_cosponsored"
    t.decimal  "missed_votes"
  end

  create_table "votes", force: :cascade do |t|
    t.date     "date"
    t.integer  "roll_call"
    t.string   "question"
    t.string   "result"
    t.integer  "total_yes"
    t.integer  "total_no"
    t.integer  "total_not_voting"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

end
