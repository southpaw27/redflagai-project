
FactoryBot.define do
  factory :task do
    title { "Test task" }
    description { "Test description." }
    due_date { 1.day.from_now }
    status { Task::Statuses::NOT_STARTED }
    project_manager
    project
  end
end
