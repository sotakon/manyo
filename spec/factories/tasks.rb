FactoryBot.define do
  factory :task do
    name { 'test_name' }
    details { 'test_details' }
    limit { 'test_limit' }
    stutas { '未着手' }
  end
  factory :second_task, class: Task do
    name { 'test_name2' }
    details { 'test_details2' }
    limit { 'test_limit2' }
    stutas { '着手中' }
  end
end
