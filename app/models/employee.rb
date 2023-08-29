class Employee < ApplicationRecord
  has_many :tasks
  has_one :user, as: :role, class_name: 'Employee'
  has_one :organization, through: :user
end
