# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140318180109) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "empleados", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.string   "apellido",   limit: 255
    t.string   "dni",        limit: 255
    t.string   "cuil",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "insumos", force: :cascade do |t|
    t.string   "tipo_de_insumo",      limit: 255
    t.text     "descripcion",         limit: 65535
    t.integer  "stock",               limit: 4,     default: 0
    t.integer  "reemplaza_insumo_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "codigo",              limit: 255
  end

  create_table "maquina_usa_insumos", force: :cascade do |t|
    t.integer  "maquina_id",  limit: 4
    t.integer  "insumo_id",   limit: 4
    t.integer  "cantidad",    limit: 4,     default: 1
    t.text     "descripcion", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "maquinas", force: :cascade do |t|
    t.string   "marca",        limit: 255
    t.string   "modelo",       limit: 255
    t.text     "descripcion",  limit: 65535
    t.string   "serie",        limit: 255
    t.integer  "horas",        limit: 4
    t.integer  "anio",         limit: 4
    t.integer  "encargado_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movimiento_de_insumos", force: :cascade do |t|
    t.integer  "insumo_id",          limit: 4
    t.string   "tipo_de_movimiento", limit: 255
    t.integer  "cantidad",           limit: 4,     default: 1
    t.text     "descripcion",        limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reparacion_id",      limit: 4
  end

  create_table "reparacions", force: :cascade do |t|
    t.integer  "maquina_id",       limit: 4
    t.text     "descripcion",      limit: 65535
    t.datetime "fecha_pedido"
    t.datetime "fecha_a_realizar"
    t.datetime "fecha_realizado"
    t.integer  "pedido_por_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
