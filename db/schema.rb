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

ActiveRecord::Schema.define(version: 2020_07_15_184648) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.integer "code", null: false
    t.integer "order_code", null: false
    t.string "name", null: false
    t.string "en_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_categories_on_code", unique: true
    t.index ["en_name"], name: "index_categories_on_en_name"
    t.index ["name"], name: "index_categories_on_name"
    t.index ["order_code"], name: "index_categories_on_order_code"
  end

  create_table "images", force: :cascade do |t|
    t.integer "code", null: false
    t.string "name", null: false
    t.binary "img", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "type_code"
    t.index ["code"], name: "index_images_on_code", unique: true
    t.index ["name"], name: "index_images_on_name"
    t.index ["type_code"], name: "index_images_on_type_code"
  end

  create_table "report_tags", force: :cascade do |t|
    t.integer "tag_code", null: false
    t.integer "report_code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tag_code", "report_code"], name: "index_report_tags_on_tag_code_and_report_code", unique: true
  end

  create_table "reports", force: :cascade do |t|
    t.integer "code", null: false
    t.integer "category_code", null: false
    t.integer "sub_category_code", null: false
    t.integer "image_code"
    t.string "title", null: false
    t.string "description", null: false
    t.text "info", null: false
    t.boolean "is_hide", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_code"], name: "index_reports_on_category_code"
    t.index ["code"], name: "index_reports_on_code", unique: true
    t.index ["image_code"], name: "index_reports_on_image_code"
    t.index ["is_hide"], name: "index_reports_on_is_hide"
    t.index ["sub_category_code"], name: "index_reports_on_sub_category_code"
    t.index ["title"], name: "index_reports_on_title"
  end

  create_table "sub_categories", force: :cascade do |t|
    t.integer "code", null: false
    t.integer "category_code", null: false
    t.integer "order_code", null: false
    t.string "name", null: false
    t.string "en_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_code"], name: "index_sub_categories_on_category_code"
    t.index ["code"], name: "index_sub_categories_on_code", unique: true
    t.index ["en_name"], name: "index_sub_categories_on_en_name"
    t.index ["name"], name: "index_sub_categories_on_name"
    t.index ["order_code"], name: "index_sub_categories_on_order_code"
  end

  create_table "tags", force: :cascade do |t|
    t.integer "code", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_tags_on_code", unique: true
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

end
