module Interactions
  module Employees
    class Create < ActiveInteraction::Base
      string :name
      string :email
      string :title
      string :work_focus
      record :project_manager

      validates :project_manager presence: true
      validates :name presence: true
      validates :email presence: true

      def execute
        user = User.create(name: name, email: email, organization: project_manager.organization)
        role = Employee.create(name: name, title: title, work_focus: work_focus)
        user.role = role
        user.save
        user
      end
    end
  end
end
