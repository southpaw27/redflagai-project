module Interactions
  module Users
    class Update < ActiveInteraction::Base
      record :user, class: ::User
      string :name
      string :email
      string :nickname, default: nil
      string :title, default: nil
      string :work_focus, default: nil

      def execute
        role = user.role

        if user.is_employee?
          role.update(
            name: nickname,
            title: title,
            work_focus: work_focus,
          )
        else
          role.update(
            name: name,
          )
        end

        user.update(
          name: name,
          email: email,
        )
      end
    end
  end
end
