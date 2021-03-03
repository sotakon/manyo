FactoryBot.define do
  factory :user do
    name { 'テスト' }
    email { 'test@gmail.com' }
    password { '123456' }
    admin { 'true' }
  end
  factory :second_user, class: User do
    name { 'テストユーザー2' }
    email { 'testtest@gmail.com' }
    password { '123456' }
    admin { 'false' }
  end
end
