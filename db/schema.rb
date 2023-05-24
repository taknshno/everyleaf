ActiveRecord::Schema.define(version: 2023_05_23_083527) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "task_name", null: false
    t.integer "status"
    t.integer "priority"
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "task_detail", null: false
    t.index ["task_name"], name: "index_tasks_on_task_name"
  end

end
