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

ActiveRecord::Schema.define(version: 20141020140358) do

  create_table "comments", force: true do |t|
    t.string  "title"
    t.string  "text"
    t.string  "author"
    t.integer "cop_id"
  end

  create_table "cops", force: true do |t|
    t.string  "name"
    t.integer "badge_number"
    t.integer "precinct_id"
    t.integer "approves",     default: 0
    t.integer "disapproves",  default: 0
  end

  create_table "precincts", force: true do |t|
    t.integer "zip_code"
    t.integer "number"
  end

end
