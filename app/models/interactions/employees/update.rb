module Interactions
  module Employees
    class Update < ActiveInteraction::Base
      string :name
      string :email
      string :title
      string :work_focus
      record :employee
      record :project_manager

      validates :project_manager, presence: true
      validates :employee, presence: true

      validate :project_manager_employee_org

      def execute
        employee.update()
      end

      def project_manager_employee_org
        unless project_manager.organization == employee.organization
          errors.add(:project_manager_employee_org, 'project manager and employee organization does not match')
        end
      end
    end
  end
end
