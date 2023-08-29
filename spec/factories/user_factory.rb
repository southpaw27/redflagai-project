
FactoryBot.define do
  factory :user do
    name { "Test Employee" }
    # email { "test@test.com" }
    password { "password" }
    organization { create(:organization) }
    
    trait :project_manager do
      role { create(:project_manager) }
      email { "projectmanager@test.com" }
    end

    trait :employee do
      role { create(:employee) }
      email { "employee@test.com" }
    end
  end
end
