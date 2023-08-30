
module Interactions
  module Projects
    class Update < ActiveInteraction::Base
      record :project, class: ::Project
      string :title
      string :description

      def execute
        project.update(
          title: title,
          description: description,
        )
      end
    end
  end
end
