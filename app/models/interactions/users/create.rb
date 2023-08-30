module Interactions
  module Users
    class Create < ActiveInteraction::Base
      string :name
      string :email
      string :password
      string :role_type
      integer :organization_id
      string :nickname, default: nil
      string :title, default: nil
      string :work_focus, default: nil

      def execute
        role = generate_role

        User.create(
          name: name,
          email: email,
          password: password,
          organization_id: organization_id,
          role: role,
        )
      end

      def generate_role
        if role_type == "ProjectManager"
          ProjectManager.create(name: name)
        elsif role_type == "Employee"
          Employee.create(name: nickname || name, title: title, work_focus: work_focus)
        else
          nil
        end
      end
    end
  end
end
