
module Interactions
  module Projects
    class Create < ActiveInteraction::Base
      string :title
      string :description
      record :project_manager, class: ::User
      record :organization, class: ::Organization

      def execute
        Project.create(
          title: title,
          description: description,
          project_manager: project_manager,
          organization: organization
        )
      end
    end
  end
end
