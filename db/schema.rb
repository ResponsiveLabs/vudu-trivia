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

ActiveRecord::Schema.define(:version => 20121224222607) do

  create_table "assignments", :force => true do |t|
    t.integer "game_id"
    t.integer "question_id"
  end

  add_index "assignments", ["game_id"], :name => "index_assignments_on_game_id"
  add_index "assignments", ["question_id"], :name => "index_assignments_on_question_id"

  create_table "games", :force => true do |t|
    t.integer  "earned_points",          :default => 0
    t.integer  "correct_answers_count",  :default => 0
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "current_question_index", :default => 0
    t.integer  "user_id"
  end

  create_table "questions", :force => true do |t|
    t.string   "title",                               :null => false
    t.text     "explanation",                         :null => false
    t.string   "answer_url"
    t.integer  "points_to_earn",   :default => 10
    t.integer  "timer_in_seconds", :default => 60
    t.boolean  "published",        :default => false
    t.datetime "started_at"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "possible_answers",                    :null => false
    t.string   "image1"
    t.string   "image2"
    t.string   "image3"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",                  :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
    t.integer  "facebook_id",            :limit => 8
    t.integer  "points",                              :default => 0
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
