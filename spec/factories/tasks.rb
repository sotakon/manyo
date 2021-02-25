FactoryBot.define do
  factory :task do
    name { 'test_name' }
    details { 'test_details' }
  end
  factory :second_task, class: Task do
    name { 'test_name2' }
    details { 'test_details2' }
  end
end
