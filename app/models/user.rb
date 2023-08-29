class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :role, polymorphic: true

  def is_project_manager?
    self.role.is_a?(ProjectManager)
  end

  def is_employee?
    self.role.is_a?(Employee)
  end
end
