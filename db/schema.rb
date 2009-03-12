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

ActiveRecord::Schema.define(:version => 20090306130651) do

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.integer  "property_id"
    t.string   "caption"
    t.string   "type"
    t.string   "item_file_name"
    t.string   "item_content_type"
    t.integer  "item_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "properties", :force => true do |t|
    t.integer  "number_address"
    t.string   "street_address"
    t.integer  "unit_number"
    t.string   "city"
    t.string   "state"
    t.integer  "zip_code"
    t.datetime "available_date"
    t.integer  "lease_type_id"
    t.string   "availability"
    t.integer  "number_beds"
    t.integer  "number_baths"
    t.integer  "square_feet"
    t.float    "lat"
    t.float    "lng"
    t.string   "type"
    t.float    "monthly_rent"
    t.float    "deposit"
    t.float    "listing_price"
    t.integer  "mls_number"
    t.text     "full_description"
    t.boolean  "laundry"
    t.boolean  "yard"
    t.boolean  "garage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
  end

end