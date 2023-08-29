class Project < ApplicationRecord
  belongs_to :project_manager, class_name: 'User'
  belongs_to :organization

  has_many :tasks
end
