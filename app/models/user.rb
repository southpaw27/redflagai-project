class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :api

  belongs_to :role, polymorphic: true
  belongs_to :organization

  before_create :setup_organization

  def is_project_manager?
    self.role.is_a?(ProjectManager)
  end

  def is_employee?
    self.role.is_a?(Employee)
  end

  def setup_organization
    if self.organization.nil?
      org = Organization.create(name: "#{self.name}'s Organization")
      user.organization = org
    end
  end
end
