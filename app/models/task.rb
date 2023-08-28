class Task < ApplicationRecord
  belongs_to :project
  belongs_to :project_manager
  belongs_to :employee, optional: true
  
  belongs_to :parent_task, class_name: "Task", optional: true
  has_many :subtasks, class_name: "Task", foreign_key: "parent_task_id", dependent: :destroy

  class Statuses
    NOT_STARTED = "not_started"
    WORKING = "working"
    NEEDS_REVIEW = "needs_review"
    DONE = "done"
    LATE = "late"

    def self.allowed_statuses
      [NOT_STARTED, WORKING, NEEDS_REVIEW, DONE, LATE]
    end

    def self.employee_statuses
      [WORKING, NEEDS_REVIEW]
    end

    def self.project_manager_statuses
      [NOT_STARTED, DONE]
    end
  end

  validates :status, inclusion: { in: Task::Statuses.allowed_statuses }
end
