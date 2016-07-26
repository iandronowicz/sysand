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

ActiveRecord::Schema.define(version: 20160724150038) do

  create_table "active_admin_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "namespace"
    t.text     "body",          limit: 65535
    t.string   "resource_id",                 null: false
    t.string   "resource_type",               null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "admin_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "archivos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "propietario_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "imagen_file_name"
    t.string   "imagen_content_type"
    t.integer  "imagen_file_size"
    t.datetime "imagen_updated_at"
  end

  create_table "clientes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "razon_social"
    t.string   "cuit"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "empleados", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.string   "dni"
    t.string   "cuil"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "insumos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "tipo_de_insumo"
    t.text     "descripcion",               limit: 65535
    t.integer  "stock",                                   default: 0
    t.integer  "reemplaza_insumo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "codigo"
    t.integer  "maquina_usa_insumos_count",               default: 0, null: false
  end

  create_table "maquina_usa_insumos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "maquina_id"
    t.integer  "insumo_id"
    t.integer  "cantidad",                  default: 1
    t.text     "descripcion", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "maquinas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "marca"
    t.string   "modelo"
    t.text     "descripcion",  limit: 65535
    t.string   "serie"
    t.integer  "horas"
    t.integer  "anio"
    t.integer  "encargado_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movimiento_de_insumos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "insumo_id"
    t.string   "tipo_de_movimiento",               default: "salida"
    t.integer  "cantidad",                         default: 1
    t.text     "descripcion",        limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "servicio_id"
  end

  create_table "servicios", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "maquina_id"
    t.text     "descripcion",     limit: 65535
    t.integer  "maquina_horas"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.boolean  "realizado",                     default: false
    t.datetime "fecha_realizado"
  end

  create_table "tareas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "descripcion"
    t.float    "cantidad",         limit: 24
    t.decimal  "precio_unitario",             precision: 11, scale: 2
    t.decimal  "precio_total",                precision: 11, scale: 2
    t.integer  "tipo_de_tarea_id"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.integer  "trabajo_id"
  end

  create_table "tipo_de_tareas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "descripcion"
    t.string   "unidad"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "trabajos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "descripcion",       limit: 65535
    t.string   "titulo"
    t.string   "estado_de_trabajo"
    t.string   "factura"
    t.integer  "cliente_id"
    t.datetime "fecha_de_inicio",                 default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "fecha_de_fin"
    t.datetime "created_at",                                                           null: false
    t.datetime "updated_at",                                                           null: false
  end

end
