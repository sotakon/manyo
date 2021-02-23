create_table "tascs", force: :cascade do |t|
  t.string "name"
  t.string "limit"
  t.string "priority"
  t.string "status"
  t.integer "id"
end

create_table "users", force: :cascade do |t|
  t.string "name"
  t.string "email"
  t.integer "password"
  t.integer "user_id"
end

create_table "labels", force: :cascade do |t|
  t.string "name"
  t.integer "label_id"
end
