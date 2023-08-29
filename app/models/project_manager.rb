class ProjectManager < ApplicationRecord
  has_many :projects
  has_many :tasks

  has_one :organization, through: :user
  
  has_one :user, as: :role, class_name: 'ProjectManager'
end
