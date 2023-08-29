module Interactions
  module Tasks
    class Create < Base
      record :project_manager, class: ::User
      record :project, class: ::Project
      string :title, default: nil
      string :description, default: nil
      string :work_focus, default: nil
      date_time :due_date, default: nil
      string :status, default: ::Task::Statuses::NOT_STARTED
      record :employee, class: ::User, default: nil
      record :parent_task, class: ::Task, default: nil

      def execute
        ::Task.create(inputs.select { |k,v| v.present? })
      end

    end
  end
end