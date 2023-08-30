# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :read, :all

    can :manage, User, id: user.id

    can [:change_status, :update_status], Task, employee_id: user.id

    return unless user.is_project_manager?

    can :manage, Task, project_manager: user
    can :manage, Project, project_manager: user
    can :manage, User, organization_id: user.organization_id
    can :create_new, User
    can :manage, Employee
    can :manage, ProjectManager, id: user.role.id
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
