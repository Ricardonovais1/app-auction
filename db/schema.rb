# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_614_142_535) do
  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.integer 'record_id', null: false
    t.integer 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false
    t.bigint 'byte_size', null: false
    t.string 'checksum'
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.integer 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'answers', force: :cascade do |t|
    t.string 'reply'
    t.integer 'question_id', null: false
    t.integer 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['question_id'], name: 'index_answers_on_question_id'
    t.index ['user_id'], name: 'index_answers_on_user_id'
  end

  create_table 'bids', force: :cascade do |t|
    t.integer 'value'
    t.integer 'user_id', null: false
    t.integer 'lot_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['lot_id'], name: 'index_bids_on_lot_id'
    t.index ['user_id'], name: 'index_bids_on_user_id'
  end

  create_table 'blocked_cpfs', force: :cascade do |t|
    t.string 'cpf'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.boolean 'blocked', default: false
  end

  create_table 'favorites', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.integer 'lot_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['lot_id'], name: 'index_favorites_on_lot_id'
    t.index ['user_id'], name: 'index_favorites_on_user_id'
  end

  create_table 'items', force: :cascade do |t|
    t.string 'name'
    t.string 'description'
    t.integer 'weight'
    t.integer 'height'
    t.integer 'depth'
    t.integer 'width'
    t.string 'code'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'product_category_id', default: 0, null: false
    t.index ['product_category_id'], name: 'index_items_on_product_category_id'
  end

  create_table 'lot_items', force: :cascade do |t|
    t.integer 'item_id', null: false
    t.integer 'lot_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['item_id'], name: 'index_lot_items_on_item_id'
    t.index ['lot_id'], name: 'index_lot_items_on_lot_id'
  end

  create_table 'lots', force: :cascade do |t|
    t.string 'code'
    t.date 'start_date'
    t.date 'limit_date'
    t.integer 'minimum_bid_value'
    t.integer 'minimum_bid_difference'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'by', default: 'Não informado'
    t.string 'by_email', default: 'Email não informado'
    t.integer 'status', default: 0
    t.string 'approved_by', default: 'none'
    t.string 'approved_by_email', default: 'none'
  end

  create_table 'product_categories', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'questions', force: :cascade do |t|
    t.integer 'lot_id', null: false
    t.integer 'user_id', null: false
    t.string 'body'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'visibility', default: 0
    t.index ['lot_id'], name: 'index_questions_on_lot_id'
    t.index ['user_id'], name: 'index_questions_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'registration_number'
    t.boolean 'admin', default: false
    t.string 'about', default: ''
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'answers', 'questions'
  add_foreign_key 'answers', 'users'
  add_foreign_key 'bids', 'lots'
  add_foreign_key 'bids', 'users'
  add_foreign_key 'favorites', 'lots'
  add_foreign_key 'favorites', 'users'
  add_foreign_key 'items', 'product_categories'
  add_foreign_key 'lot_items', 'items'
  add_foreign_key 'lot_items', 'lots'
  add_foreign_key 'questions', 'lots'
  add_foreign_key 'questions', 'users'
end
