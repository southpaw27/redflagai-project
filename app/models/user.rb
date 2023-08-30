class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :api

  belongs_to :role, polymorphic: true
  belongs_to :organization

  has_many :projects, foreign_key: :project_manager_id
  has_many :project_manager_tasks, class_name: "Task", foreign_key: :project_manager_id
  has_many :tasks, class_name: "Task", foreign_key: :employee_id

  before_validation :setup_organization, :setup_role

  scope :project_managers, -> { where(role_type: "ProjectManager") }
  scope :employees, -> { where(role_type: "Employee") }

  def is_project_manager?
    self.role.is_a?(ProjectManager)
  end

  def is_employee?
    self.role.is_a?(Employee)
  end

  # If we are signing up a new user, we assume they are the organizations first project
  # manager. Maybe not the best thing long term, but this is good for the mvp.
  # We want to setup the org, and setup the role.
  # This PM will then be able to create other PMs and employees, meaning they will
  # already have a role and organization
  def setup_organization
    if self.organization.nil?
      org = Organization.create(name: "#{self.name}'s Organization")
      self.organization = org
    end
  end

  def setup_role
    if self.role.nil?
      role = ProjectManager.create(name: self.name)
      self.role = role
    end
  end
end
