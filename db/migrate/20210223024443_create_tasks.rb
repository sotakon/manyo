class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table "tasks", force: :cascade do |t|
      t.string "name", null: false
      t.string "details", null: false
      t.datetime "limit"
      t.string "stutas"
      t.string "priority"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
