FactoryBot.define do
  factory :task do
    name { 'test_name' }
    details { 'test_details' }
    limit { 'test_limit' }
    stutas { 'test_stutas' }
  end
  factory :second_task, class: Task do
    name { 'test_name2' }
    details { 'test_details2' }
    limit { 'test_limit2' }
    stutas { 'test_stutas2' }
  end
end
