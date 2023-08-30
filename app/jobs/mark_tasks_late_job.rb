class MarkTasksLateJob < ApplicationJob
  def perform()
    Tasks.late.each do |task|
      task.update(status: ::Task::Statuses::LATE)
    end
  end
end
