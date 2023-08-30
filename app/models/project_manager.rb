class ProjectManager < ApplicationRecord
  has_one :organization, through: :user

  has_one :user, as: :role, class_name: "ProjectManager"

  def role_string
    "Project Manager"
  end
end
