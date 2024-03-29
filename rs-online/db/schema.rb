# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110118214710) do

  create_table "histories", :force => true do |t|
    t.integer  "process"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "links", :force => true do |t|
    t.string   "url",                          :null => false
    t.string   "filename"
    t.boolean  "completed"
    t.float    "size"
    t.datetime "date_started"
    t.datetime "date_finished"
    t.integer  "package_id",                   :null => false
    t.integer  "status_id",     :default => 5, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "packages", :force => true do |t|
    t.string   "description",                                                   :null => false
    t.text     "comment"
    t.boolean  "completed"
    t.boolean  "show"
    t.boolean  "problem"
    t.datetime "date_created"
    t.datetime "date_started"
    t.datetime "date_finished"
    t.string   "pass_phrase"
    t.integer  "priority_id",                                                   :null => false
    t.string   "url_source"
    t.boolean  "use_ip"
    t.decimal  "size",          :precision => 10, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "priorities", :force => true do |t|
    t.string   "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", :force => true do |t|
    t.string   "status",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
