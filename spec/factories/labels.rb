FactoryBot.define do
  factory :label do
    name { "テストラベル" }
  end
  factory :second_label, class: Label do
    name { "テストラベル2" }
  end
end
