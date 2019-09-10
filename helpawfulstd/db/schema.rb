# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_07_192235) do

  create_table "reviews", force: :cascade do |t|
    t.integer "student_id"
    t.integer "student_own_level"
    t.integer "tutor_id"
    t.string "language"
    t.integer "rating_for_tutor"
    t.string "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "s_profile_name"
    t.string "location"
    t.integer "age"
    t.string "contact_email"
    t.string "password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tutors", force: :cascade do |t|
    t.string "t_profile_name"
    t.string "location"
    t.string "language"
    t.integer "experience"
    t.integer "price"
    t.string "contact_email"
    t.string "password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
