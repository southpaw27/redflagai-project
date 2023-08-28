
FactoryBot.define do
  factory :employee do
    name { "Test Employee" }
    email { "test.employee@test.com"}
    password { "password123" }
  end
end
