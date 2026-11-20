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

ActiveRecord::Schema[8.1].define(version: 2026_11_20_200359) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "blueprints", force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "author_id", null: false
    t.string "name", null: false
    t.string "title", null: false
    t.text "summary"
    t.integer "definition_status", default: 0, null: false
    t.integer "implementation_status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_blueprints_on_author_id"
    t.index ["project_id", "name"], name: "index_blueprints_on_project_id_and_name", unique: true
    t.index ["project_id"], name: "index_blueprints_on_project_id"
  end

  create_table "federails_activities", force: :cascade do |t|
    t.string "entity_type", null: false
    t.integer "entity_id", null: false
    t.string "action", null: false
    t.integer "actor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.string "to"
    t.string "cc"
    t.index ["actor_id"], name: "index_federails_activities_on_actor_id"
    t.index ["entity_type", "entity_id"], name: "index_federails_activities_on_entity"
    t.index ["uuid"], name: "index_federails_activities_on_uuid", unique: true
  end

  create_table "federails_actors", force: :cascade do |t|
    t.string "name"
    t.string "federated_url"
    t.string "username"
    t.string "server"
    t.string "inbox_url"
    t.string "outbox_url"
    t.string "followers_url"
    t.string "followings_url"
    t.string "profile_url"
    t.integer "entity_id"
    t.string "entity_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.text "public_key"
    t.text "private_key"
    t.json "extensions"
    t.boolean "local", default: false, null: false
    t.string "actor_type"
    t.datetime "tombstoned_at"
    t.index ["entity_type", "entity_id"], name: "index_federails_actors_on_entity", unique: true
    t.index ["federated_url"], name: "index_federails_actors_on_federated_url", unique: true
    t.index ["uuid"], name: "index_federails_actors_on_uuid", unique: true
  end

  create_table "federails_followings", force: :cascade do |t|
    t.integer "actor_id", null: false
    t.integer "target_actor_id", null: false
    t.integer "status", default: 0
    t.string "federated_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.index ["actor_id", "target_actor_id"], name: "index_federails_followings_on_actor_id_and_target_actor_id", unique: true
    t.index ["actor_id"], name: "index_federails_followings_on_actor_id"
    t.index ["target_actor_id"], name: "index_federails_followings_on_target_actor_id"
    t.index ["uuid"], name: "index_federails_followings_on_uuid", unique: true
  end

  create_table "federails_hosts", force: :cascade do |t|
    t.string "domain", null: false
    t.string "nodeinfo_url"
    t.string "software_name"
    t.string "software_version"
    t.text "protocols", default: "[]"
    t.text "services", default: "{}"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["domain"], name: "index_federails_hosts_on_domain", unique: true
  end

  create_table "forum_posts", force: :cascade do |t|
    t.integer "forum_topic_id", null: false
    t.integer "author_id", null: false
    t.text "body_bbcode", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_forum_posts_on_author_id"
    t.index ["forum_topic_id"], name: "index_forum_posts_on_forum_topic_id"
  end

  create_table "forum_topics", force: :cascade do |t|
    t.integer "author_id", null: false
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_forum_topics_on_author_id"
  end

  create_table "issues", force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "author_id", null: false
    t.integer "number", null: false
    t.string "title", null: false
    t.text "body"
    t.integer "status", default: 0, null: false
    t.integer "importance", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_issues_on_author_id"
    t.index ["project_id", "number"], name: "index_issues_on_project_id_and_number", unique: true
    t.index ["project_id"], name: "index_issues_on_project_id"
  end

  create_table "lfs_objects", force: :cascade do |t|
    t.string "oid", null: false
    t.integer "size", limit: 8, null: false
    t.string "md5", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["md5"], name: "index_lfs_objects_on_md5"
    t.index ["oid"], name: "index_lfs_objects_on_oid", unique: true
  end

  create_table "projects", force: :cascade do |t|
    t.integer "owner_id", null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.integer "editor", default: 0, null: false
    t.text "description"
    t.integer "forked_from_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["forked_from_id"], name: "index_projects_on_forked_from_id"
    t.index ["owner_id", "slug"], name: "index_projects_on_owner_id_and_slug", unique: true
    t.index ["owner_id"], name: "index_projects_on_owner_id"
  end

  create_table "pull_requests", force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "author_id", null: false
    t.integer "source_project_id", null: false
    t.string "source_branch", null: false
    t.string "target_branch", null: false
    t.string "title", null: false
    t.text "body"
    t.integer "state", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_pull_requests_on_author_id"
    t.index ["project_id"], name: "index_pull_requests_on_project_id"
    t.index ["source_project_id"], name: "index_pull_requests_on_source_project_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "display_name"
    t.text "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "blueprints", "projects"
  add_foreign_key "blueprints", "users", column: "author_id"
  add_foreign_key "federails_activities", "federails_actors", column: "actor_id"
  add_foreign_key "federails_followings", "federails_actors", column: "actor_id"
  add_foreign_key "federails_followings", "federails_actors", column: "target_actor_id"
  add_foreign_key "forum_posts", "forum_topics"
  add_foreign_key "forum_posts", "users", column: "author_id"
  add_foreign_key "forum_topics", "users", column: "author_id"
  add_foreign_key "issues", "projects"
  add_foreign_key "issues", "users", column: "author_id"
  add_foreign_key "projects", "projects", column: "forked_from_id"
  add_foreign_key "projects", "users", column: "owner_id"
  add_foreign_key "pull_requests", "projects"
  add_foreign_key "pull_requests", "projects", column: "source_project_id"
  add_foreign_key "pull_requests", "users", column: "author_id"
end
