class Task < ApplicationRecord
  belongs_to :project
  belongs_to :project_manager, class_name: 'User'
  belongs_to :employee, class_name: 'User', optional: true
  
  belongs_to :parent_task, class_name: "Task", optional: true
  has_many :subtasks, class_name: "Task", foreign_key: "parent_task_id", dependent: :destroy

  validate :project_manager_is_project_manager, :employee_is_employee

  def project_manager_is_project_manager
    unless self.project_manager && self.project_manager.role.is_a?(ProjectManager)
      errors.add(:project_manager_validation, "assigned project manager is not a project manager")
    end
  end

  def employee_is_employee
    unless self.employee.nil? || self.employee.role.is_a?(Employee)
      errors.add(:employee_validation, "assigned employee is not a employee")
    end
  end

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
