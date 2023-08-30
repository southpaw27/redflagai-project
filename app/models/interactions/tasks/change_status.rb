module Interactions
  module Tasks
    class ChangeStatus < Base
      record :task, class: ::Task
      record :change_user, class: ::User
      string :status

      # validate :presence_of_change_user
      validate :change_user_is_assigned
      validate :status_change_allowed

      def execute
        task.update(status: status)
        task
      end

      # def presence_of_change_user
      #   if (project_manager && employee) || !(project_manager || employee)
      #     errors.add(:presence_of_change_user, "must have one change user")
      #   end
      # end

      def change_user_is_assigned
        unless ((change_user.is_project_manager? && task.project_manager == change_user) ||
                (change_user.is_employee? && task.employee == change_user))
          errors.add(:change_user_is_assigned, "change user is not assigned to the task")
        end
      end

      def status_change_allowed
        unless ((change_user.is_project_manager? && ::Task::Statuses.project_manager_statuses.include?(status)) ||
                (change_user.is_employee? && ::Task::Statuses.employee_statuses.include?(status)))
          errors.add(:status_change_allowed, "status change not allowed")
        end
      end
    end
  end
end
