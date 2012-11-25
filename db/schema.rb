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

ActiveRecord::Schema.define(:version => 20121125202517) do

  create_table "assignments", :force => true do |t|
    t.integer "game_id"
    t.integer "question_id"
  end

  add_index "assignments", ["game_id"], :name => "index_assignments_on_game_id"
  add_index "assignments", ["question_id"], :name => "index_assignments_on_question_id"

  create_table "games", :force => true do |t|
    t.integer  "earned_points"
    t.integer  "correct_answers_count"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "questions", :force => true do |t|
    t.string   "title"
    t.text     "explanation"
    t.string   "answer_url"
    t.integer  "points_to_earn"
    t.integer  "timer_in_seconds"
    t.boolean  "published"
    t.datetime "started_at"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
