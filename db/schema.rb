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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130303054244) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "errands", :force => true do |t|
    t.integer  "requester_id"
    t.integer  "assignee_id"
    t.integer  "source_place_id"
    t.integer  "arrival_place_id"
    t.string   "summary"
    t.text     "description"
    t.datetime "deadline"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "size"
  end

  create_table "messages", :force => true do |t|
    t.integer  "from_user_id"
    t.integer  "to_user_id"
    t.string   "subject"
    t.text     "body"
    t.string   "read_status"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "offers", :force => true do |t|
    t.integer  "courier_id"
    t.integer  "source_place_id"
    t.integer  "arrival_place_id"
    t.datetime "leaving_at"
    t.datetime "arriving_at"
    t.string   "summary"
    t.text     "description"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "size"
  end

  create_table "places", :force => true do |t|
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.integer  "postal_code"
    t.string   "display_name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "population"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.integer  "home_place_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
