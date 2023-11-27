ActiveRecord::Schema[7.1].define(version: 2023_11_17_141038) do
  create_table "amenities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "custom_prices", force: :cascade do |t|
    t.string "daily_price"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "room_id", null: false
    t.index ["room_id"], name: "index_custom_prices_on_room_id"
  end

  create_table "full_addresses", force: :cascade do |t|
    t.string "address"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number"
    t.string "complement"
  end

  create_table "guesthouse_payment_methods", force: :cascade do |t|
    t.integer "guesthouse_id", null: false
    t.integer "payment_method_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guesthouse_id"], name: "index_guesthouse_payment_methods_on_guesthouse_id"
    t.index ["payment_method_id"], name: "index_guesthouse_payment_methods_on_payment_method_id"
  end

  create_table "guesthouses", force: :cascade do |t|
    t.string "brand_name"
    t.string "corporate_name"
    t.string "register_number"
    t.string "phone_number"
    t.string "email"
    t.string "description"
    t.string "pet_friendly"
    t.string "terms"
    t.datetime "check_in_time"
    t.datetime "check_out_time"
    t.string "status"
    t.integer "full_address_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["full_address_id"], name: "index_guesthouses_on_full_address_id"
    t.index ["user_id"], name: "index_guesthouses_on_user_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "room_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.integer "num_guests"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_reservations_on_room_id"
  end

  create_table "room_amenities", force: :cascade do |t|
    t.integer "room_id", null: false
    t.integer "amenity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amenity_id"], name: "index_room_amenities_on_amenity_id"
    t.index ["room_id"], name: "index_room_amenities_on_room_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.integer "maximum_guests"
    t.string "description"
    t.string "dimension"
    t.string "daily_price"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "guesthouse_id", null: false
    t.index ["guesthouse_id"], name: "index_rooms_on_guesthouse_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_type"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "custom_prices", "rooms"
  add_foreign_key "guesthouse_payment_methods", "guesthouses"
  add_foreign_key "guesthouse_payment_methods", "payment_methods"
  add_foreign_key "guesthouses", "full_addresses"
  add_foreign_key "guesthouses", "users"
  add_foreign_key "reservations", "rooms"
  add_foreign_key "room_amenities", "amenities"
  add_foreign_key "room_amenities", "rooms"
  add_foreign_key "rooms", "guesthouses"
end
