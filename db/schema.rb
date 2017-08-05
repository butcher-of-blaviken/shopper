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

ActiveRecord::Schema.define(version: 20170805175405) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favourites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_id"
    t.index ["user_id", "product_id"], name: "index_favourites_on_user_id_and_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "alcohol_content"
    t.text "description"
    t.integer "inventory_count"
    t.integer "inventory_price_in_cents"
    t.integer "inventory_volume_in_milliliters"
    t.string "name"
    t.string "origin"
    t.text "package"
    t.string "package_unit_type"
    t.integer "package_unit_volume_in_milliliters"
    t.integer "price_in_cents"
    t.string "primary_category"
    t.integer "regular_price_in_cents"
    t.string "style"
    t.string "image_url"
    t.string "image_thumb_url"
    t.string "tags"
    t.string "varietal"
    t.integer "volume_in_milliliters"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_activities", force: :cascade do |t|
    t.integer "user_id"
    t.integer "object_id"
    t.integer "action"
    t.datetime "time_performed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "object_id"], name: "index_user_activities_on_user_id_and_object_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
