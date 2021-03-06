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

ActiveRecord::Schema.define(:version => 20101119123118) do

  create_table "forecasts", :force => true do |t|
    t.string   "zip_code",            :null => false
    t.string   "city",                :null => false
    t.integer  "current_temperature", :null => false
    t.integer  "humidity",            :null => false
    t.string   "conditions",          :null => false
    t.string   "wind",                :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.datetime "time",                :null => false
  end

end
