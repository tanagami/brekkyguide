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

ActiveRecord::Schema.define(version: 20190223013542) do

  create_table "hotels", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "kananame"
    t.string   "special"
    t.string   "address1"
    t.string   "address2"
    t.string   "access"
    t.string   "image_url"
    t.string   "thumbnail_url"
    t.string   "review_count"
    t.string   "review_average"
    t.string   "meal_average"
    t.string   "breakfast_place"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
