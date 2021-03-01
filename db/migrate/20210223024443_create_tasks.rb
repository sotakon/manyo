class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table "tasks", force: :cascade do |t|
      t.string "name", null: false
      t.string "details", null: false
      t.date "limit"
      t.string "stutas"
      t.integer "priority"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
