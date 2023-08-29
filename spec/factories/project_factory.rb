
FactoryBot.define do
  factory :project do
    title { "Test Project" }
    description { "A test project" }
    project_manager
    organization { create(:organization) }
  end
end
