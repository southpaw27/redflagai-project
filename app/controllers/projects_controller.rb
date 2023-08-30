class ProjectsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
  end

  def edit
  end

  def update
    outcome = Interactions::Projects::Update.run(title: project_params[:title], description: project_params[:description], project: @project)
    if outcome.valid?
      redirect_to "/"
    else
      render edit_project_path(project)
    end
  end

  def create
    outcome = Interactions::Projects::Create.run(title: project_params[:title], description: project_params[:description], project_manager: current_user, organization: current_user.organization)
    if outcome.valid?
      redirect_to @project
    else
      render "edit"
    end
  end

  def new
  end

  def delete
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :project_manager_id, :organization_id)
  end
end
